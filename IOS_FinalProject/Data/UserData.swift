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
    var player1: playerData
    var player2: playerData
}
struct playerData: Codable {
    var flag: Int
    var Name: String
    var Body: Int
    var Eye: Int
    var Hat: Int
}
/*extension UserData{
    static var previewData: UserData{
        UserData(Gender: 0, Age: 20)
    }
}
*/
