//
//  CreateAccount.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/18.
//

import SwiftUI

struct CreateAccount: View {
    @EnvironmentObject private var DataComponent: userData
    @Binding var isCreate: Bool
    @State private var isSignUpPage = false
    @State private var alertMsg:String = ""
    @State private var showAlert = false
    @State private var myAlert = Alert(title: Text(""))
    var body: some View {
        VStack{
            VStack{
                Text("建立帳號")
                    .font(.custom("HanziPenTC-W5", size: 50))
                    .foregroundColor(.white)
            }
            VStack{
                Form{
                    VStack{
                        HStack{
                            Text("帳號")
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                            Spacer()
                            Image("mark_email")
                        }
                        TextField("輸入使用者信箱", text: $DataComponent.Email)
                            .frame(height: 40)
                    }
                    VStack{
                        HStack{
                            Image("mark_password")
                            
                            Spacer()
                            Text("密碼")
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                        }
                        TextField("輸入使用者密碼", text: $DataComponent.Password)
                            .frame(height: 40)
                    }
                }
            }
            HStack{
                Button(action: {
                    isCreate = false
                }, label: {
                    Image("backButton")
                        .resizable()
                        .frame(width: 100, height: 100)
                })
                .padding()
                .padding()
                Button(action: {
                    //createUser
                    if DataComponent.Email != "" && DataComponent.Password != ""{
                        Firebase.shared.createUser(userEmail: DataComponent.Email, pw: DataComponent.Password){
                            (result) in
                            switch result {
                            case .success( _):
                                showAlertMsg(msg: "註冊成功")
                            case .failure(let errormsg):
                                print("註冊失敗")
                                switch errormsg {
                                case .emailFormatWrong:
                                    showAlertMsg(msg: "電子郵件格式不正確")
                                case .emailUsed:
                                    showAlertMsg(msg: "電子郵件已被註冊")
                                case .pwtooShort:
                                    showAlertMsg(msg: "密碼長度需至少大於6")
                                case .others:
                                    showAlertMsg(msg: "不明原因錯誤，請重新註冊")
                                }
                                break
                            }
                        }
                    }
                    
                }, label: {
                    Image("circle_ok")
                        .resizable()
                        .frame(width: 100, height: 100)
                })
                .padding()
                .alert(isPresented: $showAlert) { () -> Alert in
                    return myAlert
                }
                .fullScreenCover(isPresented: $isSignUpPage, content: {
                    SignupPage()
                })
            }.frame(height: 200)
        }.background(
            Image("starbackground")
                .contrast(0.8))
    }
    func gotoSignUpPage() -> Void {
        isSignUpPage = true
    }
    func showAlertMsg(msg: String) -> Void {
        self.alertMsg = msg
        if alertMsg == "註冊成功"{
            self.myAlert = Alert(title: Text("成功"), message: Text(alertMsg), dismissButton: .cancel(Text("進入角色畫面"), action: gotoSignUpPage))
            self.showAlert = true
        }
        else{
            self.myAlert = Alert(title: Text("發生錯誤"), message: Text(alertMsg), dismissButton: .cancel(Text("重新登入")))
            self.showAlert = true
        }
    }
}
struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccount(isCreate: .constant(true))
            .environmentObject(userData())
    }
}
