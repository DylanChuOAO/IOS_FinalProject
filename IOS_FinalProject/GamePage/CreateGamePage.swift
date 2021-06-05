//
//  CreateGamePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct CreateGamePage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @Binding var isCreateGamePage: Bool
    @State private var isWaitingRoomPage = false
    @State private var currentUser = Auth.auth().currentUser
    @State private var currentUserData = UserData(Body: 0, Eye: 0, Hat: 0, Name: "", Email: "", Password: "",Gender: 0, Age: 18)
    @State private var alertMsg = ""
    @State private var showAlert = false
    @State private var myAlert = Alert(title: Text(""))
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            VStack{
                Text("建立遊戲")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            VStack{
                ScrollView{
                    VStack{
                        HStack{
                            Text("房號")
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                                .padding()
                            Spacer()
                            Image("building_house1")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding()
                        }
                        HStack{
                            Text(GameDataComponent.roomNameString)
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                                .frame(width: 150, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.purple
                                                .blur(radius: 6)
                                                .cornerRadius(20))
                                .padding()
                            Spacer()
                        }
                    }.background(Color.yellow
                                    .blur(radius: 6)
                                    .cornerRadius(20))
                    .padding()
                }
                VStack{
                    Button(action: {
                        let randomNum = Int.random(in: 100000..<1000000)
                        GameDataComponent.roomNameString = String(randomNum)
                    }, label: {
                        Image("dice")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                                    .frame(width: 220, height: 220)
                            )
                    }).padding()
                    HStack{
                        Button(action: {
                            isCreateGamePage = false
                        }, label: {
                            Image("navigation_back")
                                .resizable()
                                .frame(width: 150, height: 75)
                        }).padding()
                        Button(action: {
                            let newUser1 = playerData(flag: 0, Name: currentUserData.Name,  Body: currentUserData.Body, Eye: currentUserData.Eye, Hat: currentUserData.Hat)
                            print(newUser1)
                            let newUser2 = playerData(flag: 0, Name: "", Body: -1,  Eye:-1, Hat: -1)
                            let newgame = GameData( roomNameString: GameDataComponent.roomNameString,  player1: newUser1, player2: newUser2)
                            Firebase.shared.createRoom(GameData: newgame, roomID: GameDataComponent.roomNameString){ (result) in
                                switch result{
                                case .success(let successmsg):
                                    print(successmsg)
                                    isWaitingRoomPage = true
                                case .failure(_):
                                    print("建立房間失敗")
                                }
                            }
                        }, label: {
                            Image("navigation_next")
                                .resizable()
                                .frame(width: 150, height: 75)
                        }).padding()
                    }.padding()
                }
            }
        }
        .background(
            Image("mountain_background")
                .contrast(0.8))
        .fullScreenCover(isPresented: $isWaitingRoomPage, content: {
            WaitingRoomPage()
        })
        .onAppear{
            Firebase.shared.fetchUsers(){ result in
                switch (result) {
                case .success(let dataArray):
                    for i in dataArray {
                        if i.id == currentUser?.uid {
                            currentUserData = i
                            break
                        }
                    }
                case .failure(_):
                    print("抓取失敗")
                }
            }
        }
    }
    func showAlertMsg(msg: String) -> Void {
        self.alertMsg = msg
        if alertMsg == "建立房間成功" {
            self.myAlert = Alert(title: Text("成功"), message: Text(alertMsg), dismissButton: .default(Text("進入等待室"), action: {
                self.presentationMode.wrappedValue.dismiss()}))
            self.showAlert = true
        }
        else {
            self.myAlert = Alert(title: Text("錯誤"), message: Text(alertMsg), dismissButton:
                .cancel(Text("重新選擇房號")))
            self.showAlert = true
        }
    }
}
struct CreateGamePage_Previews: PreviewProvider {
    static var previews: some View {
        CreateGamePage(isCreateGamePage: .constant(true))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
