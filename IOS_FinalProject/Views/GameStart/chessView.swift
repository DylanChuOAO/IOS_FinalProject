//
//  chessView.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/11.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct chessView: View {
    var x: Int
    var y: Int
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var UIColor = Color(red: 238/255, green: 186/255, blue: 85/255)
    @State private var currentRoomData = GameData(roomNameString: "", gamestart: true, chessboard: boards, flag: 0, whoWin: -1, finish: false, player1: playerData(Suit: "黑", Name: "123", Body: 0, Eye: 0, Hat: 0), player2: playerData(Suit: "白", Name: "234", Body: 0, Eye: 0, Hat: 0))
    // let xy = (x*9)+y
    @ViewBuilder var body: some View{
        VStack{
            /*
             
                 if UserDataComponent.Currentselected == x*9 + y{
                     Image(currentRoomData.chessboard[x*9+y].data)
                         .resizable()
                         .scaledToFit()
                         .frame(width: 25, height: 25, alignment: .center)
                         .border(Color.red, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                 }else{
             */
            if UserDataComponent.Currentselected == x*9 + y{
                ZStack{
                    Image(currentRoomData.chessboard[x*9+y].data)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: .center)
                }.frame(width: 30, height: 30, alignment: .center)
                .border(Color.red, width: 2)
            }else{
                ZStack{
                    Image(currentRoomData.chessboard[x*9+y].data)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: .center)
                }
                .frame(width: 30, height: 30, alignment: .center)
                .border(Color.black, width: 2)
            }
        }.background(UIColor)
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
             //更新房間
             Firebase.shared.checkRoomsChange(roomID: GameDataComponent.roomNameString){ result in
                 switch (result) {
                 case .success(let updatedRooms):
                     currentRoomData = updatedRooms
                 case .failure(_):
                     print("房間更新失敗")
                 }
             }
        }
    }
}

struct chessView_Previews: PreviewProvider {
    static var previews: some View {
        chessView(x: 1, y: 1)
    }
}
