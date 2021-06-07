//
//  FirebaseControl.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/5.
//
import SwiftUI
import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class Firebase: ObservableObject{
    static let shared = Firebase()
    //建立使用者帳號
    func createUser(userEmail: String, pw: String, completion: @escaping((Result<String, RegError>) -> Void)) {
        Auth.auth().createUser(withEmail: userEmail, password: pw) { result, error in
             guard let user = result?.user,
                   error == nil else {
                if (error?.localizedDescription == "Your email format error"){
                    completion(.failure(RegError.emailFormatWrong))
                }
                else if(error?.localizedDescription == "The password must be at least 6 characters"){
                    completion(.failure(RegError.pwtooShort))
                }
                else if(error?.localizedDescription == "This account has already registered"){
                    completion(.failure(RegError.emailUsed))
                }
                else {
                    completion(.failure(RegError.others))
                }
                return
             }
            print(user.email, user.uid)
            completion(.success(user.uid))
        }
    }
    //帳密登入
    func userSignIn(userEmail: String, pw: String, completion: @escaping((Result<String, LoginError>) -> Void)) {
        Auth.auth().signIn(withEmail: userEmail, password: pw) { result, error in
             guard error == nil else {
                print(error?.localizedDescription)
                /*if (error?.localizedDescription == "The password is invalid or the user does not have a password.") {
                    completion(.failure(LoginError.pwError))
                }
                else if (error?.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted.") {
                    completion(.failure(LoginError.AccountError))
                }
                else {
                    completion(.failure(LoginError.others))
                }*/
                return
             }
            completion(.success("Success"))
        }
    }
    //登出
    func userSignOut() -> Void {
        do {
            try Auth.auth().signOut()
            if Auth.auth().currentUser == nil {
                print("登出成功")
            }
        }
        catch {
            print("登出錯誤")
        }
    }
    //上傳相片
    func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".png")
        if let data = image.pngData() {
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                    fileReference.downloadURL { result in
                        switch result {
                        case .success(let url):
                            completion(.success(url))
                            print(url)
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    //使用者頭像
    func setUserPhoto(url: URL, completion: @escaping((Result<String, NormalErr>) -> Void)) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.photoURL = url
        completion(.success("頭像修改成功"))
        changeRequest?.commitChanges(completion: { error in
           guard error == nil else {
               print(error?.localizedDescription)
                completion(.failure(NormalErr.error))
               return
           }
        })
    }
    //修改user display name
    func setUserDisplayName(userDisplayName: String) -> Void {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userDisplayName
        changeRequest?.commitChanges(completion: { error in
           guard error == nil else {
                print(error?.localizedDescription)
                print("修改user display name出錯")
                return
           }
        })
    }
    //上傳基本資料
    func createUserData(userData: UserData, uid: String, completion: @escaping((Result<String, NormalErr>) -> Void)) {
        let db = Firestore.firestore()
        do {
            try db.collection("Users").document(uid).setData(from: userData)
            //print(documentReference.documentID)
            completion(.success("建立資料成功"))
        } catch {
            completion(.failure(NormalErr.error))
            print(error)
        }
    }
    //讀取某個collection下全部的 documents
    func fetchUsers(completion: @escaping((Result<[UserData], NormalErr>) -> Void)) {
        let db = Firestore.firestore()
        db.collection("Users").getDocuments{ snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: UserData.self)
                //guard let song = try? documentChange.document.data(as: Song.self) else { return }
            }
            print(users)
            completion(.success(users))
            if error?.localizedDescription != nil {
                completion(.failure(NormalErr.error))
            }
        }
    }
    //建立房間
    func createRoom(GameData: GameData, roomID: String, completion: @escaping((Result<String, NormalErr>) -> Void)){
        let db = Firestore.firestore()
        do{
            try db.collection("Rooms").document(roomID).setData(from: GameData)
            completion(.success("建立房間成功"))
        } catch {
            completion(.failure(NormalErr.error))
            print(error)
        }
    }
    //玩家2 加入房間 修改player2
    func joinRoom(player: playerData, roomID: String, completion: @escaping((Result<String, NormalErr>) -> Void)) {
        let db = Firestore.firestore()
        let documentReference = db.collection("Rooms").document(roomID)
        documentReference.getDocument{ document, error in
            guard let document = document,
                  document.exists,
                  var room = try? document.data(as: GameData.self)
            else{ return }
            room.player2 = player
            do {
                try documentReference.setData(from: room)
                completion(.success("加入房間成功"))
            } catch {
                completion(.failure(NormalErr.error))
                print(error)
            }
            print(room)
        }
    }
    //Gamestart 修改gamestart = true
    func gameStart(gamestart: Bool, roomID: String, completion: @escaping((Result<String, NormalErr>) -> Void)){
        let db = Firestore.firestore()
        let documentReference = db.collection("Rooms").document(roomID)
        documentReference.getDocument{ document, error in
            guard let document = document,
                  document.exists,
                  var room = try? document.data(as: GameData.self)
            else{ return }
            room.gamestart = gamestart
            do {
                try documentReference.setData(from: room)
                completion(.success("進入遊戲成功"))
            } catch {
                completion(.failure(NormalErr.error))
                print(error)
            }
            print(room)
        }
    }
    //讀取某個collection下全部的 documents
    //Rooms
    func fetchRooms(completion: @escaping((Result<[GameData], NormalErr>) -> Void)) {
        let db = Firestore.firestore()
        db.collection("Rooms").getDocuments{ snapshot, error in
            guard let snapshot = snapshot else { return}
            let rooms = snapshot.documents.compactMap{ snapshot in
                try? snapshot.data(as: GameData.self)
            }
            print(rooms)
            completion(.success(rooms))
            if error?.localizedDescription != nil {
                completion(.failure(NormalErr.error))
            }
        }
    }
    //持續偵測資料是否更新
    func checkRoomsChange(roomID: String, completion: @escaping((Result<GameData, NormalErr>) -> Void)) {
        let db = Firestore.firestore()
        db.collection("Rooms").document("\(roomID)").addSnapshotListener{ snapshot, error in
            guard let snapshot = snapshot else { return }
            do {
                let rooms = try snapshot.data(as: GameData.self)!
                completion(.success(rooms))
            } catch {
                completion(.failure(NormalErr.error))
            }
        }
    }
}
enum RegError: Error {
    case emailFormatWrong//格式錯誤
    case pwtooShort //密碼太短
    case emailUsed //Email已註冊
    case others //其他狀況
}

enum LoginError: Error {
    case pwError
    case AccountError
    case others
}

enum NormalErr: Error {
    case error
}

