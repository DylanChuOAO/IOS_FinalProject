//
//  ContentView.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/4/28.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject private var DataComponent: userData
    @State private var alertText: String = ""
    @State private var showAlert = false
    @State private var isGamePage = false
    @State private var isCreate = false
    @State private var returnBool = false
 var body: some View {
    NavigationView{
        VStack{
            Image("amongusTitle")
                .resizable()
                .scaledToFit()
                .frame(width:300)
            Spacer()
            VStack{
                HStack{
                    Text("帳號：")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                        .padding()
                    TextField("Enter your Email", text: $DataComponent.Email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                }
                HStack{
                    Text("密碼：")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.blue)
                        .padding()
                    TextField("Enter your password", text: $DataComponent.Password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing)
                }
            }.background(Color.orange
                            .blur(radius: 6)
                            .cornerRadius(20))
            .padding()
            HStack{
                Button(action: {//建立帳號按鈕
                    isCreate = true
                }, label: {
                    Text("建立帳號")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(width: 150,height: 40)
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding()
                })
                .fullScreenCover(isPresented: $isCreate, content: {
                    CreateAccount(isCreate: $isCreate)
                })
                Spacer()
                Button(action: { //繼續按鈕
                    Firebase.shared.userSignIn(userEmail: DataComponent.Email, pw: DataComponent.Password){
                        (result) in
                        switch result {
                        case .success(_):
                            //成功
                            if let user = Auth.auth().currentUser{
                                print("\(user.uid) 登入成功")
                                Firebase.shared.fetchUsers(){
                                    (result) in
                                    switch result{
                                    case .success(let Iarray):
                                        print("\(user.uid)資料抓取成功")
                                        for i in Iarray{
                                            if i.id == user.uid{
                                                returnBool = true
                                            }
                                        }
                                        isGamePage = true
                                    case .failure(_):
                                        print("\(user.uid)資料抓取失敗")
                                        returnBool = false
                                    }
                                }
                            } else{
                                print("登入失敗")
                            }
                        case .failure(let errormessage):
                            switch errormessage {
                            case .pwError:
                                alertText = "密碼錯誤"
                                showAlert = true
                            case .AccountError:
                                alertText = "此帳號不存在"
                                showAlert = true
                            case .others:
                                alertText = "未知的問題"
                                showAlert = true
                            }
                        }
                    }
                }, label: {
                    Text("繼續")
                        .font(.custom("jf-openhuninn-1.1", size: 25))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(width: 100,height: 40)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .multilineTextAlignment(.trailing)
                        .cornerRadius(8)
                        .padding()
                })
                /*if returnBool {
                    EmptyView().fullScreenCover(isPresented: $showView)
                        { UserView()}
                }
                else {
                    EmptyView().fullScreenCover(isPresented: $showView)
                        { FirstLoginView(userEmail: userEmail, userPW: userPW) }
                }*/
                .fullScreenCover(isPresented: $isGamePage, content: {
                    GamePage()
                })
            }
            Spacer()
        }.background(Image("amongusBG")
                        .scaledToFill()
                        .blur(radius: 1.5))
    }
    .alert(isPresented: $showAlert, content: { () -> Alert in
        return Alert(title: Text("錯誤"), message: Text(alertText), dismissButton: .default(Text("重新輸入")))
    })
 }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}

