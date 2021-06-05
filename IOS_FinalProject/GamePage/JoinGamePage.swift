//
//  JoinGamePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct JoinGamePage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @Binding var isJoinGamePage: Bool
    @State private var isWaitingRoomPage = false
    @State private var currentUser = Auth.auth().currentUser
    @State private var currentUserData = UserData(Body: 0, Eye: 0, Hat: 0, Name: "", Email: "", Password: "",Gender: 0, Age: 18)
    var body: some View {
        VStack{
            VStack{
                Text("加入遊戲")
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
                            Image("mark_key")
                                .padding()
                        }
                        HStack{
                            TextField(" 輸入房名", text: $GameDataComponent.roomNameString)
                                .frame(width: 150, height: 70, alignment: .center)
                                .background(Color.yellow
                                                .blur(radius: 6)
                                                .cornerRadius(20))
                                .padding()
                            Spacer()
                        }
                    }.background(Color.purple
                                    .blur(radius: 6)
                                    .cornerRadius(20))
                    .padding()
                }
                HStack{
                    Button(action: {
                        isJoinGamePage = false
                    }, label: {
                        Image("navigation_back")
                            .resizable()
                            .frame(width: 150, height: 75)
                    }).padding()
                    Button(action: {
                        let newUser2 = playerData(flag: 1, Name: currentUserData.Name,  Body: currentUserData.Body, Eye: currentUserData.Eye, Hat: currentUserData.Hat)
                        Firebase.shared.joinRoom(player: newUser2, roomID: GameDataComponent.roomNameString){
                            (result) in
                            switch result {
                            case .success(let successmsg):
                                print("進入房間成功")
                                print(isWaitingRoomPage)
                                isWaitingRoomPage = true
                                print(successmsg)
                            case .failure(_):
                                print("進入房間失敗")
                            }
                        }
                    }, label: {
                        Image("navigation_next")
                            .resizable()
                            .frame(width: 150, height: 75)
                    }).padding()
                }.padding()
            }
        }.background(
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
}

struct JoinGamePage_Previews: PreviewProvider {
    static var previews: some View {
        JoinGamePage(isJoinGamePage: .constant(true))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
