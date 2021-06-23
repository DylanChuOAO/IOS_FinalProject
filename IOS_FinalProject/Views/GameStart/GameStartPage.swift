//
//  GameStartPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/1.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
struct GameStartPage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var GameDataComponent: gameData
    @State private var currentRoomData = GameData(roomNameString: "", gamestart: true, chessboard: boards, flag: 0, whoWin: -1, finish: false, player1: playerData(Suit: "黑", Name: "123", Body: 0, Eye: 0, Hat: 0), player2: playerData(Suit: "白", Name: "234", Body: 0, Eye: 0, Hat: 0))
    @State private var UIColor = Color(red: 238/255, green: 186/255, blue: 85/255)
    @State private var X: String = ""
    @State private var Y: String = ""
    @State private var alertText: String = ""
    @State private var alertButtonText: String = ""
    @State private var showAlert = false
    @State private var isWinPage = false
    var boardView: some View {
        VStack{
            HStack{
                VStack{
                    ZStack{
                        Image("0")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("7")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("8")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                VStack{
                    ZStack{
                        Image("9")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 0, y: 0)
                    chessView(x: 0, y: 1)
                    chessView(x: 0, y: 2)
                    chessView(x: 0, y: 3)
                    chessView(x: 0, y: 4)
                    chessView(x: 0, y: 5)
                    chessView(x: 0, y: 6)
                    chessView(x: 0, y: 7)
                    chessView(x: 0, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 1, y: 0)
                    chessView(x: 1, y: 1)
                    chessView(x: 1, y: 2)
                    chessView(x: 1, y: 3)
                    chessView(x: 1, y: 4)
                    chessView(x: 1, y: 5)
                    chessView(x: 1, y: 6)
                    chessView(x: 1, y: 7)
                    chessView(x: 1, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 2, y: 0)
                    chessView(x: 2, y: 1)
                    chessView(x: 2, y: 2)
                    chessView(x: 2, y: 3)
                    chessView(x: 2, y: 4)
                    chessView(x: 2, y: 5)
                    chessView(x: 2, y: 6)
                    chessView(x: 2, y: 7)
                    chessView(x: 2, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 3, y: 0)
                    chessView(x: 3, y: 1)
                    chessView(x: 3, y: 2)
                    chessView(x: 3, y: 3)
                    chessView(x: 3, y: 4)
                    chessView(x: 3, y: 5)
                    chessView(x: 3, y: 6)
                    chessView(x: 3, y: 7)
                    chessView(x: 3, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 4, y: 0)
                    chessView(x: 4, y: 1)
                    chessView(x: 4, y: 2)
                    chessView(x: 4, y: 3)
                    chessView(x: 4, y: 4)
                    chessView(x: 4, y: 5)
                    chessView(x: 4, y: 6)
                    chessView(x: 4, y: 7)
                    chessView(x: 4, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 5, y: 0)
                    chessView(x: 5, y: 1)
                    chessView(x: 5, y: 2)
                    chessView(x: 5, y: 3)
                    chessView(x: 5, y: 4)
                    chessView(x: 5, y: 5)
                    chessView(x: 5, y: 6)
                    chessView(x: 5, y: 7)
                    chessView(x: 5, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("7")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 6, y: 0)
                    chessView(x: 6, y: 1)
                    chessView(x: 6, y: 2)
                    chessView(x: 6, y: 3)
                    chessView(x: 6, y: 4)
                    chessView(x: 6, y: 5)
                    chessView(x: 6, y: 6)
                    chessView(x: 6, y: 7)
                    chessView(x: 6, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("8")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 7, y: 0)
                    chessView(x: 7, y: 1)
                    chessView(x: 7, y: 2)
                    chessView(x: 7, y: 3)
                    chessView(x: 7, y: 4)
                    chessView(x: 7, y: 5)
                    chessView(x: 7, y: 6)
                    chessView(x: 7, y: 7)
                    chessView(x: 7, y: 8)
                }
            }
            HStack{
                VStack{
                    ZStack{
                        Image("9")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                }
                Group{
                    chessView(x: 8, y: 0)
                    chessView(x: 8, y: 1)
                    chessView(x: 8, y: 2)
                    chessView(x: 8, y: 3)
                    chessView(x: 8, y: 4)
                    chessView(x: 8, y: 5)
                    chessView(x: 8, y: 6)
                    chessView(x: 8, y: 7)
                    chessView(x: 8, y: 8)
                }
            }
        }.background(UIColor)
    }
    func checkisblank(xy: Int) -> Bool {
        if currentRoomData.chessboard[xy].data == "無"{
            return true
        }else{ //黑或白
            alertText = "已經有棋子了"
            alertButtonText = "改位置"
            showAlert = true
            return false
        }
    }
    func RowWin(xy: Int, flag: Int, suit: String) -> Void {
        var Connect = 1
        //判斷直五子
        for i in 1...4{
            //上
            if xy-i*9 < 0{ break }
            if(currentRoomData.chessboard[xy-i*9].data == suit){
                Connect += 1
            }
            else { break }
        }
        for i in 1...4{
            //下
            if xy-i*9 > 80{ break }
            if(currentRoomData.chessboard[xy+i*9].data == suit){
                Connect += 1
            }
            else { break }
        }
        if Connect >= 5{
            currentRoomData.whoWin = flag
            currentRoomData.finish = true
        }
    }
    func ColWin(xy: Int, flag: Int, suit: String) -> Void {
        var Connect = 1
        //判斷橫五子
        for i in 1...4{
            //左
            if (xy-i) % 9 == 8 || (xy-i) < 0{ break }
            if(currentRoomData.chessboard[xy-i].data == suit){
                Connect += 1
            }
            else { break }
        }
        for i in 1...4{
            //右
            if (xy+i) % 9 == 0 || (xy-i) > 80{ break }
            if(currentRoomData.chessboard[xy+i].data == suit){
                Connect += 1
            }else { break }
        }
        if Connect >= 5{
            currentRoomData.whoWin = flag
            currentRoomData.finish = true
        }
    }
    func ObliWin1(xy: Int, flag: Int, suit: String) -> Void {
        var Connect = 1
        //判斷左上 右下
        for i in 1...4{
            //左上
            if (xy-i*10) % 9 == 8 || (xy-i*10) < 0{ break }
            if(currentRoomData.chessboard[xy-i*10].data == suit){
                Connect += 1
            }else { break }
        }
        for i in 1...4{
            //右下
            if (xy+i*10) % 9 == 0 || (xy+i*10) > 80{ break }
            if(currentRoomData.chessboard[xy+i*10].data == suit){
                Connect += 1
            }else { break }
        }
        if Connect >= 5{
            currentRoomData.whoWin = flag
            currentRoomData.finish = true
        }
    }
    func ObliWin2(xy: Int, flag: Int, suit: String) -> Void {
        var Connect = 1
        //判斷右上 左下
        for i in 1...4{
            //右上
            if (xy-8*i) % 9 == 0 || (xy-8*i) < 0 { break }
            if(currentRoomData.chessboard[xy-8*i].data == suit){
                Connect += 1
            }else { break }
        }
        for i in 1...4{
            //左下
            if (xy+8*i) % 9 == 8 || (xy+8*i) > 80 { break }
            if(currentRoomData.chessboard[xy+8*i].data == suit){
                Connect += 1
            }else { break }
        }
        if Connect >= 5{
            currentRoomData.whoWin = flag
            currentRoomData.finish = true
        }
    }
    func checkWin(xy: Int, flag: Int, suit: String) -> Void {
        //判斷直五子
        RowWin(xy: xy, flag: flag, suit: suit)
        //判斷橫五子
        ColWin(xy: xy, flag: flag, suit: suit)
        //判斷左上 右下
        ObliWin1(xy: xy, flag: flag, suit: suit)
        //判斷右上 左下
        ObliWin2(xy: xy, flag: flag, suit: suit)
    }
    func Buttonup() ->  Void{
        if UserDataComponent.Currentselected >= 9{
            UserDataComponent.Currentselected -= 9
        }
    }
    func Buttondown() ->  Void{
        if UserDataComponent.Currentselected <= 71{
            UserDataComponent.Currentselected += 9
        }
    }
    func Buttonleft() ->  Void{
        if UserDataComponent.Currentselected%9 != 0{
            UserDataComponent.Currentselected -= 1
        }
    }
    func Buttonright() ->  Void{
        if UserDataComponent.Currentselected%9 != 8{
            UserDataComponent.Currentselected += 1
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
                    Text("遊戲開始")
                        .font(.custom("HanziPenTC-W5", size: 40))
                    Text(currentRoomData.roomNameString)
                        .font(.custom("HanziPenTC-W5", size: 25))
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
            boardView
            ScrollView{
                HStack{
                    VStack{
                        //上
                        Button(action: {
                            Buttonup()
                        }, label: {
                            Image("up")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                                .border(Color.black, width: 1)
                        })
                        HStack{
                            //左
                            Button(action: {
                                Buttonleft()
                            }, label: {
                                Image("left")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .border(Color.black, width: 1)
                            })
                            Spacer()
                            //右
                            Button(action: {
                                Buttonright()
                            }, label: {
                                Image("right")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80, alignment: .center)
                                    .border(Color.black, width: 1)
                            })
                        }
                        //下
                        Button(action: {
                            Buttondown()
                        }, label: {
                            Image("down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80, alignment: .center)
                                .border(Color.black, width: 1)
                        })
                        /*HStack{
                         Image("x")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 80, height: 80, alignment: .center)
                         TextField(" 輸入X(列)", text: $X)
                             .frame(width: 100, height: 70, alignment: .center)
                             .background(Color.yellow
                                             .blur(radius: 6)
                                             .cornerRadius(20))
                             .padding()
                     }.background(Color.blue
                                     .blur(radius: 6)
                                     .cornerRadius(20))
                     HStack{
                         Image("y")
                             .resizable()
                             .scaledToFit()
                             .frame(width: 80, height: 80, alignment: .center)
                         TextField(" 輸入y(行)", text: $Y)
                             .frame(width: 100, height: 70, alignment: .center)
                             .background(Color.yellow
                                             .blur(radius: 6)
                                             .cornerRadius(20))
                             .padding()
                     }.background(Color.blue
                                     .blur(radius: 6)
                                     .cornerRadius(20))*/
                    }
                    //GO button
                    Button(action: {
                        let xy = UserDataComponent.Currentselected
                        //P1介面、 遊戲說輪到P2了
                        if UserDataComponent.CreateRoom == 0 && currentRoomData.flag == 1{
                            alertText = "還沒輪到你"
                            alertButtonText = "等等對手"
                            showAlert = true
                        }
                        //P2介面、 遊戲說輪到P1了
                        if UserDataComponent.CreateRoom == 1 && currentRoomData.flag == 0{
                            alertText = "還沒輪到你"
                            alertButtonText = "等等對手"
                            showAlert = true
                        }
                        //P1介面、 遊戲說輪到P1了 P1為黑子
                        if UserDataComponent.CreateRoom == 0 && currentRoomData.flag == 0{
                            showAlert = false
                            if checkisblank(xy: xy){
                                //check (x,y)沒棋子
                                currentRoomData.chessboard[xy].data = "黑"
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("黑棋.1成功")
                                    case .failure(_):
                                        print("黑棋.1失敗")
                                    }
                                }
                                checkWin(xy: xy, flag: 0, suit: "黑")
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("黑棋.2成功")
                                    case .failure(_):
                                        print("黑棋.2失敗")
                                    }
                                }
                                currentRoomData.flag = 1
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("黑棋.3成功")
                                    case .failure(_):
                                        print("黑棋.3失敗")
                                    }
                                }
                            }
                        }
                        //P2介面、 遊戲說輪到P2了 P2為白子
                        if UserDataComponent.CreateRoom == 1 && currentRoomData.flag == 1{
                            showAlert = false
                            if checkisblank(xy: xy){
                                //check (x,y)沒棋子
                                currentRoomData.chessboard[xy].data = "白"
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("白棋.1成功")
                                    case .failure(_):
                                        print("白棋.1失敗")
                                    }
                                }
                                checkWin(xy: xy, flag: 1, suit: "白")
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("白棋.2成功")
                                    case .failure(_):
                                        print("白棋.2失敗")
                                    }
                                }
                                currentRoomData.flag = 0
                                Firebase.shared.upadateAll(gameData: currentRoomData, roomID: GameDataComponent.roomNameString){ result in
                                    switch (result) {
                                    case .success(_):
                                        print("白棋.3成功")
                                    case .failure(_):
                                        print("白棋.3失敗")
                                    }
                                }
                            }
                        }
                    }, label: {
                        Image("circle_ok")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100, alignment: .center)
                    }).alert(isPresented: $showAlert, content: { () -> Alert in
                        return Alert(title: Text("錯誤"), message: Text(alertText), dismissButton: .default(Text(alertButtonText)))
                    })
                }
            }
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .fullScreenCover(isPresented: $currentRoomData.finish, content: {
            WinPage()
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

struct GameStartPage_Previews: PreviewProvider {
    static var previews: some View {
        GameStartPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
