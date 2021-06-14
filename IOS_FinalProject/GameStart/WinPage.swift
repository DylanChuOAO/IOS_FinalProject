//
//  WinPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/11.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
struct WinPage: View {
    @State private var isGamePage = false
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var currentRoomData = GameData(roomNameString: "", gamestart: true, chessboard: boards, flag: 0, whoWin: -1,finish: false, player1: playerData(Suit: "黑", Name: "123", Body: 0, Eye: 0, Hat: 0), player2: playerData(Suit: "白", Name: "234", Body: 0, Eye: 0, Hat: 0))
    @ViewBuilder var body: some View {
        VStack{
            VStack{
                Text("勝利畫面")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            if currentRoomData.whoWin == 0 {//P1
                VStack{
                    Text(currentRoomData.player1.Name+"贏了")
                        .font(.custom("HanziPenTC-W5", size: 50))
                    ZStack{
                        Image("body\(currentRoomData.player1.Body)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("eye\(currentRoomData.player1.Eye)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("hat\(currentRoomData.player1.Hat)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: -10, y: -95)
                    }
                }
            }else if currentRoomData.whoWin == 1 {//P2
                VStack{
                    Text(currentRoomData.player2.Name+"贏了")
                        .font(.custom("HanziPenTC-W5", size: 50))
                    ZStack{
                        Image("body\(currentRoomData.player2.Body)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("eye\(currentRoomData.player2.Eye)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("hat\(currentRoomData.player2.Hat)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80, alignment: .center)
                            .offset(x: -10, y: -95)
                    }
                }
            }
            Button(action: {
                isGamePage = true
            }, label: {
                Image("navigation_home")
            })
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .fullScreenCover(isPresented: $isGamePage, content: {
            GamePage()
        })
        .onAppear{
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
        }
    }
}
struct WinPage_Previews: PreviewProvider {
    static var previews: some View {
        WinPage()
    }
}
