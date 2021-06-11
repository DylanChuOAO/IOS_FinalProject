//
//  UserData.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/18.
//
import Foundation
import FirebaseFirestoreSwift

class userData: ObservableObject {
    @Published var Body: Int = 0
    @Published var Eye: Int = 0
    @Published var Hat: Int = 0
    @Published var Name: String = ""
    @Published var Email: String = ""
    @Published var Password: String = ""
    @Published var Gender: Int = 0
    @Published var Age: Float = 18
    @Published var CreateRoom: Int = 0
}
struct UserData: Codable, Identifiable {
    @DocumentID var id: String?
    let Body: Int
    let Eye: Int
    let Hat: Int
    let Name: String
    let Email: String
    let Password: String
    let Gender: Int
    let Age: Int
}
class gameData: ObservableObject {
    @Published var roomNameString: String = ""
}
struct GameData: Codable, Identifiable {
    @DocumentID var id: String?
    var roomNameString: String
    var gamestart: Bool
    var chessboard: [chessboard]
    var chessdata: [chessdata]
    var flag: Int
    var FirstClick: Bool  //選紅黑
    var isSelected: Bool
    var selectedrank: Int
    var selectedsuit: String
    var selectedposition: Int
    var player1: playerData
    var player2: playerData
}

struct playerData: Codable {
    var Suit: String
    var Name: String
    var Body: Int
    var Eye: Int
    var Hat: Int
}
/*
 1 2 3 4
 5 6 7 8
 .......
 29 30 31 32
 */
struct chessboard: Codable {
    var index: Int
    var selected: Bool
}
struct chessdata: Codable {
    var index: Int
    var data: String
    var rank: Int
    var suit: String
    var state: Int
    //state 0:暗 1:明 2:死
}
var boards = [
    chessboard(index: -1, selected: false),//0
    chessboard(index: -1, selected: false),//1
    chessboard(index: -1, selected: false),//2
    chessboard(index: -1, selected: false),//3
    chessboard(index: -1, selected: false),//4
    chessboard(index: -1, selected: false),//5
    chessboard(index: -1, selected: false),//6
    chessboard(index: -1, selected: false),//7
    chessboard(index: -1, selected: false),//8
    chessboard(index: -1, selected: false),//9
    chessboard(index: -1, selected: false),//10
    chessboard(index: -1, selected: false),//11
    chessboard(index: -1, selected: false),//12
    chessboard(index: -1, selected: false),//13
    chessboard(index: -1, selected: false),//14
    chessboard(index: -1, selected: false),//15
    chessboard(index: -1, selected: false),//16
    chessboard(index: -1, selected: false),//17
    chessboard(index: -1, selected: false),//18
    chessboard(index: -1, selected: false),//19
    chessboard(index: -1, selected: false),//20
    chessboard(index: -1, selected: false),//21
    chessboard(index: -1, selected: false),//22
    chessboard(index: -1, selected: false),//23
    chessboard(index: -1, selected: false),//24
    chessboard(index: -1, selected: false),//25
    chessboard(index: -1, selected: false),//26
    chessboard(index: -1, selected: false),//27
    chessboard(index: -1, selected: false),//28
    chessboard(index: -1, selected: false),//29
    chessboard(index: -1, selected: false),//30
    chessboard(index: -1, selected: false),//31
]
//state 0:暗 1:明 2:死
var chesses = [
    chessdata(index: 0, data: "卒", rank: 0, suit: "黑", state: 0),
    chessdata(index: 1, data: "卒", rank: 0, suit: "黑", state: 0),
    chessdata(index: 2, data: "卒", rank: 0, suit: "黑", state: 0),
    chessdata(index: 3, data: "卒", rank: 0, suit: "黑", state: 0),
    chessdata(index: 4, data: "卒", rank: 0, suit: "黑", state: 0),
    chessdata(index: 5, data: "砲", rank: 1, suit: "黑", state: 0),
    chessdata(index: 6, data: "砲", rank: 1, suit: "黑", state: 0),
    chessdata(index: 7, data: "馬", rank: 2, suit: "黑", state: 0),
    chessdata(index: 8, data: "馬", rank: 2, suit: "黑", state: 0),
    chessdata(index: 9, data: "車", rank: 3, suit: "黑", state: 0),
    chessdata(index: 10, data: "車", rank: 3, suit: "黑", state: 0),
    chessdata(index: 11, data: "象", rank: 4, suit: "黑", state: 0),
    chessdata(index: 12, data: "象", rank: 4, suit: "黑", state: 0),
    chessdata(index: 13, data: "士", rank: 5, suit: "黑", state: 0),
    chessdata(index: 14, data: "士", rank: 5, suit: "黑", state: 0),
    chessdata(index: 15, data: "將", rank: 6, suit: "黑", state: 0),
    chessdata(index: 16, data: "兵", rank: 0, suit: "紅", state: 0),
    chessdata(index: 17, data: "兵", rank: 0, suit: "紅", state: 0),
    chessdata(index: 18, data: "兵", rank: 0, suit: "紅", state: 0),
    chessdata(index: 19, data: "兵", rank: 0, suit: "紅", state: 0),
    chessdata(index: 20, data: "兵", rank: 0, suit: "紅", state: 0),
    chessdata(index: 21, data: "炮", rank: 1, suit: "紅", state: 0),
    chessdata(index: 22, data: "炮", rank: 1, suit: "紅", state: 0),
    chessdata(index: 23, data: "傌", rank: 2, suit: "紅", state: 0),
    chessdata(index: 24, data: "傌", rank: 2, suit: "紅", state: 0),
    chessdata(index: 25, data: "俥", rank: 3, suit: "紅", state: 0),
    chessdata(index: 26, data: "俥", rank: 3, suit: "紅", state: 0),
    chessdata(index: 27, data: "相", rank: 4, suit: "紅", state: 0),
    chessdata(index: 28, data: "相", rank: 4, suit: "紅", state: 0),
    chessdata(index: 29, data: "仕", rank: 5, suit: "紅", state: 0),
    chessdata(index: 30, data: "仕", rank: 5, suit: "紅", state: 0),
    chessdata(index: 31, data: "帥", rank: 6, suit: "紅", state: 0),
    chessdata(index: 32, data: "", rank: -1, suit: "", state: -1)
]
/*
index
 黑
 0~4:卒
 5、6:砲
 7、8:馬
 9、10:車
 11、12:象
 13、14:士
 15:將
 紅
 16~20:兵
 21、22:炮
 23、24:傌
 25、26:俥
 27、28:相
 29、30:仕
 31:帥
 32:為空
 */
