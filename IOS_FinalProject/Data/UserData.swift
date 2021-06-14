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
    @Published var CreateRoom: Int = -1
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
    var flag: Int//0:黑 1:白
    var whoWin: Int
    var finish: Bool
    var player1: playerData
    var player2: playerData
}

struct playerData: Codable {
    var Suit: String //"黑：P1,白 : P2"
    var Name: String
    var Body: Int
    var Eye: Int
    var Hat: Int
}
struct chessboard: Codable {
    var data: String//"無" "黑" "白"
}
var boards = [ //9*9
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//1
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//2
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//3
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//4
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//5
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//6
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//7
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//8
    chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"), chessboard(data: "無"),//9
]
