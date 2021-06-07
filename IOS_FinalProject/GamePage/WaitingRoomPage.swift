//
//  WaitingRoomPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/1.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct WaitingRoomPage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var currentRoomData = GameData(roomNameString: "", gamestart: false, player1: playerData(flag: -1, Name: "", Body: -1, Eye: -1, Hat: -1), player2: playerData(flag: -1, Name: "", Body: -1, Eye: -1, Hat: -1))
    @State private var ImageString = ""
    @State private var alertText: String = ""
    @State private var alertButtonText: String = ""
    @State private var showAlert = false
    var body: some View {
        VStack{
            VStack{
                Text("等待房間")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            ScrollView{
                HStack{
                    VStack{
                        Text(currentRoomData.roomNameString)
                            .font(.custom("HanziPenTC-W5", size: 25))
                        +
                        Text(" 房")
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                    }.padding()
                    Spacer()
                    Image("ready")
                        .resizable()
                        .frame(width: 150, height: 100, alignment: .center)
                        .padding()
                }
            }.background(Color.pink
                            .blur(radius: 6)
                            .cornerRadius(20))
            .padding()
            ScrollView{
                HStack{
                    VStack{
                        Text("Player1")
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                        Text(currentRoomData.player1.Name)
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                            .padding()
                    }.padding()
                    Spacer()
                    VStack{
                        Spacer()
                        ZStack{
                            Image("body\(currentRoomData.player1.Body)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220, alignment: .center)
                                .offset(x: 0, y: 0)
                            Image("eye\(currentRoomData.player1.Eye)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220, alignment: .center)
                                .offset(x: 0, y: 0)
                            Image("hat\(currentRoomData.player1.Hat)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .offset(x: -5, y: -62)
                        }.padding()
                        .frame(width: 160, height: 100, alignment: .center)
                    }
                }
            }.background(Color.orange
                            .blur(radius: 6)
                            .cornerRadius(20))
            .padding()
            ScrollView{
                HStack{
                    VStack{
                        Text("Player2")
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                        Text(currentRoomData.player2.Name)
                            .font(.custom("jf-openhuninn-1.1", size: 25))
                            .padding()
                    }.padding()
                    Spacer()
                    VStack{
                        Spacer()
                        ZStack{
                            Image("body\(currentRoomData.player2.Body)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220, alignment: .center)
                                .offset(x: 0, y: 0)
                            Image("eye\(currentRoomData.player2.Eye)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220, alignment: .center)
                                .offset(x: 0, y: 0)
                            Image("hat\(currentRoomData.player2.Hat)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50, alignment: .center)
                                .offset(x: -5, y: -62)
                        }.padding()
                        .frame(width: 160, height: 100, alignment: .center)
                    }
                }
            }.background(Color.blue
                            .blur(radius: 6)
                            .cornerRadius(20))
            .padding()
            Button(action: {
                if UserDataComponent.CreateRoom == 1 && currentRoomData.player2.Name != ""{
                    Firebase.shared.gameStart(gamestart: true, roomID: GameDataComponent.roomNameString){ result in
                        switch result {
                        case .success(let successmsg):
                            print(successmsg)
                        case .failure(_):
                            print("進入遊戲失敗")
                        }
                    }
                }
                else if UserDataComponent.CreateRoom == 2 {
                    showAlert = true
                    alertText = "你不是房長"
                    alertButtonText = "等房長"
                }
            }, label: {
                Image(ImageString)
                    .resizable()
                    .frame(width: 150, height: 100, alignment: .center)
                    .padding()
            })
            .alert(isPresented: $showAlert, content: { () -> Alert in
                return Alert(title: Text("錯誤"), message: Text(alertText), dismissButton: .default(Text(alertButtonText)))
            })
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .onAppear{
            //根據玩家1、2 有不同的button格式
            if UserDataComponent.CreateRoom == 1{
                ImageString = "circle_ok"
            }else if UserDataComponent.CreateRoom == 2{
                ImageString = "circle_ng"
            }
            //抓取房間
            Firebase.shared.fetchRooms(){ result in
                switch (result) {
                case .success(let dataArray):
                    for i in dataArray{
                        if i.id == GameDataComponent.roomNameString{
                            currentRoomData = i
                            break
                        }
                    }
                case .failure(_):
                    print("房間抓取失敗")
                }
            }
            //更新房間
            Firebase.shared.checkRoomsChange(roomID: GameDataComponent.roomNameString){ result in
                switch (result) {
                case .success(let updatedRooms):
                    currentRoomData = updatedRooms
                    print("gamestart \(currentRoomData.gamestart)")
                case .failure(_):
                    print("房間更新失敗")
                }
            }
        }
        .fullScreenCover(isPresented: $currentRoomData.gamestart, content: {
            GameStartPage()
        })
    }
}

struct WaitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
