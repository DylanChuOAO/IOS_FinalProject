//
//  GameStartPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/1.
//

import SwiftUI

struct GameStartPage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var UIColor = Color(red: 238/255, green: 186/255, blue: 85/255)
    @State private var player1light: String = "greenlight"
    @State private var player2light: String = "redlight"
    @State private var bordercolor = Color.black
    @State private var currentRoomData = GameData(roomNameString: "", gamestart: false, chessboard: boards, chessdata: chesses, flag: 0, FirstClick: false, isSelected: false, selectedrank: -1, selectedsuit:"",selectedposition: -1, player1: playerData(Suit: "", Name: "", Body: -1, Eye: -1, Hat: -1), player2: playerData(Suit: "", Name: "", Body: -1, Eye: -1, Hat: -1))

    struct chessView: View {
        var number: Int
        @EnvironmentObject private var UserDataComponent: userData
        @EnvironmentObject private var GameDataComponent: gameData
        @State private var UIColor2 = Color(red: 32/255, green: 114/255, blue: 69/255)
        @State private var currentRoomData = GameData(roomNameString: "", gamestart: false, chessboard: boards, chessdata: chesses, flag: 0, FirstClick: false, isSelected: false, selectedrank: -1, selectedsuit:"",selectedposition: -1, player1: playerData(Suit: "", Name: "", Body: -1, Eye: -1, Hat: -1), player2: playerData(Suit: "", Name: "", Body: -1, Eye: -1, Hat: -1))
        @State private var imageString: String = ""
        var chessbackView: some View{
            ZStack{
                Circle()
                    .foregroundColor(UIColor2)
                    .frame(width: 60, height: 60, alignment: .center)
            }.frame(width: 70, height: 70, alignment: .center)
            .border(Color.black)
        }
        @ViewBuilder var body: some View{
            VStack{
                if currentRoomData.chessdata[currentRoomData.chessboard[number].index].state == 0{ //暗
                    chessbackView
                }
                else if currentRoomData.chessdata[currentRoomData.chessboard[number].index].state == 1 && currentRoomData.chessboard[number].selected == true{ //明 選棋子 變紅框
                    VStack{
                        Image(currentRoomData.chessdata[currentRoomData.chessboard[number].index].data)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                    }.frame(width: 70, height: 70, alignment: .center)
                    .border(Color.red)
                }
                else if currentRoomData.chessdata[currentRoomData.chessboard[number].index].state == 1{ //明
                    VStack{
                        Image(currentRoomData.chessdata[currentRoomData.chessboard[number].index].data)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                    }.frame(width: 70, height: 70, alignment: .center)
                    .border(Color.black)
                }
                else if currentRoomData.chessdata[currentRoomData.chessboard[number].index].state == 2{ //死
                    VStack{
                        Image("")
                    }
                }
            }.onAppear{
                //時時上傳房間
                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                    switch (result){
                    case .success(let msg):
                        print(msg)
                    case .failure(_):
                        print("時時上傳房間失敗")
                    }
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
        }
    }
    func AeatB(A: Int, B: Int) -> Void {//AB位置
        currentRoomData.chessdata[currentRoomData.chessboard[B].index].state = 2
        currentRoomData.chessboard[B].index = currentRoomData.chessdata[A].index
        currentRoomData.chessboard[A].index = -1
        //令-1為空
    }
    func AmovetoB(A:Int, B: Int) -> Void {//AB位置
        currentRoomData.chessboard[B].index = currentRoomData.chessdata[A].index
        currentRoomData.chessboard[A].index = -1
        //令-1為空
    }
    func flagChange(flag: Int) -> Void {
        switch flag {//換人
        case 0://0->1
            currentRoomData.flag = 1
        case 1://1->0
            currentRoomData.flag = 0
        default:
            print("flag換人失敗")
        }
    }
    func clickChess(position: Int, flag: Int) -> Void {//flag 0:p1 1:p2
        let num = currentRoomData.chessboard[position].index
        let state = currentRoomData.chessdata[num].state
        let suit = currentRoomData.chessdata[num].suit
        let rank = currentRoomData.chessdata[num].rank
        if currentRoomData.FirstClick == false{//選顏色
            currentRoomData.FirstClick = true
            if suit == "紅"{
                currentRoomData.player1.Suit = "紅"
                currentRoomData.player2.Suit = "黑"
            }else if suit == "黑"{
                currentRoomData.player1.Suit = "黑"
                currentRoomData.player2.Suit = "紅"
            }
        }else if currentRoomData.FirstClick == true && currentRoomData.isSelected == false{
            switch state {
            case 0:
                currentRoomData.chessdata[num].state = 1//暗變明
                flagChange(flag: currentRoomData.flag)
            case 1: //玩家 點明棋子
                //selected
                if flag == 0 && currentRoomData.isSelected == false{
                    if suit == currentRoomData.player1.Suit {
                        currentRoomData.chessboard[position].selected = true
                        currentRoomData.isSelected = true
                        currentRoomData.selectedrank = rank
                        currentRoomData.selectedsuit = suit
                        currentRoomData.selectedposition = position
                    }
                }else if flag == 1 && currentRoomData.isSelected == false{
                    if suit == currentRoomData.player2.Suit {
                        currentRoomData.chessboard[position].selected = true
                        currentRoomData.isSelected = true
                        currentRoomData.selectedrank = rank
                        currentRoomData.selectedsuit = suit
                        currentRoomData.selectedposition = position
                    }
                }
                else if currentRoomData.isSelected == true{
                    //移動
                    if num == -1{
                        let move = abs(position - currentRoomData.selectedposition)
                        if move == 1 || move == 4 {//移動到空格
                            AmovetoB(A: currentRoomData.selectedposition, B: position)
                            flagChange(flag: currentRoomData.flag)
                            currentRoomData.isSelected = false
                        }
                    }
                    //吃掉 //砲吃
                    else if currentRoomData.selectedrank == 1 && currentRoomData.selectedsuit != suit {
                        let selectedX = currentRoomData.selectedposition / 4
                        let selectedY = currentRoomData.selectedposition % 4
                        let X = position / 4
                        let Y = position % 4
                        var distance = abs(position - currentRoomData.selectedposition)
                        if X == selectedX && distance > 1 { //平行
                            var count = 0
                            var minY = -1
                            if selectedY > Y{
                                minY = Y
                            }else {//if selectedY < Y
                                minY = selectedY
                            }
                            repeat{
                                let checkposition = X * 4 + minY + (distance - 1)
                                let index = currentRoomData.chessboard[checkposition].index
                                if index != -1{//不為空
                                    count += 1
                                }
                                distance -= 1
                            }while(distance > 1)
                            if count == 1 {
                                AeatB(A: currentRoomData.selectedposition, B: position)
                                flagChange(flag: currentRoomData.flag)
                                currentRoomData.isSelected = false
                            }
                        }
                        if Y == selectedY && distance > 1 { //垂直
                            var count = 0
                            var minX = -1
                            if selectedX > X{
                                minX = X
                            }else{
                                minX = selectedX
                            }
                            repeat{
                                let checkposition = minX * 4 + Y + ((distance - 1 ) * 4)
                                let index = currentRoomData.chessboard[checkposition].index
                                if index != -1{
                                    count += 1
                                }
                                distance -= 1
                            }while(distance > 1)
                            if count == 1 {
                                AeatB(A: currentRoomData.selectedposition, B: position)
                                flagChange(flag: currentRoomData.flag)
                                currentRoomData.isSelected = false
                            }
                        }
                    }
                    //吃掉 卒吃帥、兵
                    else if currentRoomData.selectedrank == 0 && currentRoomData.selectedsuit != suit{
                        let move = abs(position - currentRoomData.selectedposition)
                         if move == 1 || move == 4 {
                             if rank == 0 && rank == 6{
                                 AeatB(A: currentRoomData.selectedposition, B: position)
                                 flagChange(flag: currentRoomData.flag)
                                 currentRoomData.isSelected = false
                             }
                         }
                    }
                }
            default:
                print("chess error")
            }
        }
    }
    var body: some View {
        VStack{
            HStack{
                VStack{
                    ZStack{
                        Image("body\(currentRoomData.player1.Body)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("eye\(currentRoomData.player1.Eye)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("hat\(currentRoomData.player1.Hat)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26, alignment: .center)
                            .offset(x: -2, y: -30)
                    }
                    Text(currentRoomData.player1.Name)
                }
                VStack{
                    Spacer()
                    Text("遊戲開始")
                        .font(.custom("HanziPenTC-W5", size: 40))
                    HStack{
                        Image("greenlight")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                        Image("redlight")
                            .resizable()
                            .scaledToFit()
                    }
                }
                VStack{
                    ZStack{
                        Image("body\(currentRoomData.player2.Body)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("eye\(currentRoomData.player2.Eye)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                            .offset(x: 0, y: 0)
                        Image("hat\(currentRoomData.player2.Hat)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26, alignment: .center)
                            .offset(x: -2, y: -30)
                    }
                    Text(currentRoomData.player2.Name)
                }
            }.padding(.vertical)
            VStack{
                HStack{//1
                    Button(action: {
                        clickChess(position: 0, flag: currentRoomData.flag)
                    }, label: {
                        chessView(number: 0)
                    })
                    Button(action: {
                        clickChess(position: 1, flag: currentRoomData.flag)
                    }, label: {
                        chessView(number: 1)
                    })
                    Button(action: {
                        clickChess(position: 2, flag: currentRoomData.flag)
                    }, label: {
                        chessView(number: 2)
                    })
                    Button(action: {
                        clickChess(position: 3, flag: currentRoomData.flag)
                    }, label: {
                        chessView(number: 3)
                    })
               }
                HStack{//2
                    Button(action: {
                        clickChess(position: 4, flag: currentRoomData.flag)
                    }, label: {
                        chessView(number: 4)
                     })
                     Button(action: {
                        clickChess(position: 5, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 5)
                     })
                     Button(action: {
                        clickChess(position: 6, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 6)
                     })
                     Button(action: {
                        clickChess(position: 7, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 7)
                     })
                }
                HStack{//3
                    Button(action: {
                        clickChess(position: 8, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 8)
                     })
                     Button(action: {
                        clickChess(position: 9, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 9)
                     })
                     Button(action: {
                        clickChess(position: 10, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 10)
                     })
                     Button(action: {
                        clickChess(position: 11, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 11)
                     })
                }
                HStack{//4
                    Button(action: {
                        clickChess(position: 12, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 12)
                     })
                     Button(action: {
                        clickChess(position: 13, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 13)
                     })
                     Button(action: {
                        clickChess(position: 14, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 14)
                     })
                     Button(action: {
                        clickChess(position: 15, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 15)
                     })
                }
                HStack{//5
                    Button(action: {
                        clickChess(position: 16, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 16)
                     })
                     Button(action: {
                        clickChess(position: 17, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 17)
                     })
                     Button(action: {
                        clickChess(position: 18, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 18)
                     })
                     Button(action: {
                        clickChess(position: 19, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 19)
                     })
                }
                HStack{
                    Button(action: {
                        clickChess(position: 20, flag: currentRoomData.flag)
                    }, label: {//6
                         chessView(number: 20)
                     })
                     Button(action: {
                        clickChess(position: 21, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 21)
                     })
                     Button(action: {
                        clickChess(position: 22, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 22)
                     })
                     Button(action: {
                        clickChess(position: 23, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 23)
                     })
                }
                HStack{//7
                    Button(action: {
                        clickChess(position: 24, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 24)
                     })
                     Button(action: {
                        clickChess(position: 25, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 25)
                     })
                     Button(action: {
                        clickChess(position: 26, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 26)
                     })
                     Button(action: {
                        clickChess(position: 27, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 27)
                     })
                }
                HStack{//8
                    Button(action: {
                        clickChess(position: 28, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 28)
                     })
                     Button(action: {
                        clickChess(position: 29, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 29)
                     })
                     Button(action: {
                        clickChess(position: 30, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 30)
                     })
                     Button(action: {
                        clickChess(position: 31, flag: currentRoomData.flag)
                    }, label: {
                         chessView(number: 31)
                     })
                }
                Spacer()
            }
            .background(UIColor)
            .padding()
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .onAppear{
         //紅綠燈
            if currentRoomData.flag == 0{//輪到玩家一
                player1light = "greenlight"
                player2light = "redlight"
            }else if currentRoomData.flag == 1{//輪到玩家二
                player1light = "redlight"
                player2light = "greenlight"
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
    }
}

struct GameStartPage_Previews: PreviewProvider {
    static var previews: some View {
        GameStartPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
