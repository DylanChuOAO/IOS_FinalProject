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
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var currentRoomData = GameData(roomNameString: "", player1: playerData(flag: -1, Name: "", Body: -1, Eye: -1, Hat: -1), player2: playerData(flag: -1, Name: "", Body: -1, Eye: -1, Hat: -1))
    
    /*var charcterView: some View{
     ZStack{
         Image("body\(currentUserData.Body)")
             .resizable()
             .scaledToFit()
             .frame(width: 300, height: 300, alignment: .center)
             .offset(x: 0, y: 0)
         Image("eye\(currentUserData.Eye)")
             .resizable()
             .scaledToFit()
             .frame(width: 300, height: 300, alignment: .center)
             .offset(x: 0, y: 0)
         Image("hat\(currentUserData.Hat)")
             .resizable()
             .scaledToFit()
             .frame(width: 80, height: 80, alignment: .center)
             .offset(x: -10, y: -95)
     }.frame(width: 300, height: 300, alignment: .center)
 }*/
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
                            .font(.custom("HanziPenTC-W5", size: 40))
                        +
                        Text(" 號房")
                            .font(.custom("jf-openhuninn-1.1", size: 30))
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
                            .font(.custom("jf-openhuninn-1.1", size: 35))
                            .padding()
                        Text(currentRoomData.player1.Name)
                            .font(.custom("jf-openhuninn-1.1", size: 35))
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
                            .font(.custom("jf-openhuninn-1.1", size: 35))
                            .padding()
                        Text(currentRoomData.player2.Name)
                            .font(.custom("jf-openhuninn-1.1", size: 35))
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
            Image("navigation_go")
                .padding()
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .onAppear{
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
                    print("抓取失敗")
                }
            }
        }
    }
}

struct WaitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
