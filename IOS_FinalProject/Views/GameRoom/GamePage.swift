//
//  ContinuePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/10.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct GamePage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var isCreateGamePage = false
    @State private var isJoinGamePage = false
    @State private var isUserDataPage = false
    @State private var isContentView = false
    var body: some View {
        VStack{
            VStack{
                Text("五子棋")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            VStack{
                Spacer()
                Image("chessTitle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                Spacer()
                Button(action: {
                    isCreateGamePage = true
                }, label: {
                    Text("建立遊戲")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .frame(width: 200,height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 3)
                        ).padding()
                }).fullScreenCover(isPresented: $isCreateGamePage, content: {
                    CreateGamePage(isCreateGamePage: $isCreateGamePage)
                })
                Button(action: {
                    isJoinGamePage = true
                }, label: {
                    Text("加入遊戲")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .frame(width: 200,height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 3)
                        ).padding()
                }).fullScreenCover(isPresented: $isJoinGamePage, content: {
                    JoinGamePage(isJoinGamePage: $isJoinGamePage)
                })
                Button(action: {
                    isUserDataPage = true
                }, label: {
                    Text("個人資料")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .frame(width: 200,height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 3)
                        ).padding()
                }).fullScreenCover(isPresented: $isUserDataPage, content: {
                    UserDataPage(isUserDataPage: $isUserDataPage)
                })
                Link(destination: URL(string: "https://zh.wikipedia.org/wiki/五子棋".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")!, label: {
                    Text("遊戲規則")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .frame(width: 200,height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 3)
                        ).padding()
                })
                Button(action: {
                    Firebase.shared.userSignOut()
                    isContentView = true
                }, label: {
                    Text("登出")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .frame(width: 200,height: 30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 3)
                        ).padding()
                }).fullScreenCover(isPresented: $isContentView, content: {
                    ContentView()
                })
                Spacer()
            }
        }.background(
            Image("mountain_background")
                .contrast(0.8))
    }
}

struct ContinuePage_Previews: PreviewProvider {
    static var previews: some View {
       GamePage()
        .environmentObject(userData())
        .environmentObject(gameData())
    }
}
