//
//  SignupPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/8.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct SignupPage: View {
    @State private var currentUser = Auth.auth().currentUser
    @EnvironmentObject private var DataComponent : userData
    @State private var isCharacters = false
    @State private var ischoose = false
    @State private var isGamePage = false
    @State var CharacterImage : UIImage = UIImage(named: "BASE") ?? UIImage()
    @State private var genderSelect = 0
    @State private var age:Float = 18
    @State private var alertMsg = ""
    @State private var showAlert = false
    @State private var myAlert = Alert(title: Text(""))
    var roles : [Gender] = [Gender.Male,Gender.Female]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var charcterBaseView: some View{
        ZStack{
            Image("body\(DataComponent.Body)")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .offset(x: 0, y: 0)
            Image("eye\(DataComponent.Eye)")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .offset(x: 0, y: 0)
            Image("hat\(DataComponent.Hat)")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
                .offset(x: -10, y: -95)
        }.frame(width: 300, height: 300, alignment: .center)
    }
    var body: some View {
            VStack{
                VStack{
                    Text("建立帳號")
                        .font(.custom("HanziPenTC-W5", size: 50))
                        .foregroundColor(.white)
                }
                VStack{
                    if(ischoose){
                        Image(uiImage: CharacterImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300,height: 300)
                            .border(Color.white, width: 5)
                    }else{
                        charcterBaseView
                            .border(Color.white, width: 5)
                    }
                    HStack{
                       
                        Button(action: {
                            isCharacters = true
                            ischoose = true
                        }, label: {
                            Text("選擇角色")
                                .font(.custom("jf-openhuninn-1.1", size: 25))
                                .foregroundColor(Color.white)
                                .frame(width: 200,height: 30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 3)
                                ).padding()
                        })
                        .fullScreenCover(isPresented: $isCharacters, content: {
                            CharactersPage(isCharacters: $isCharacters, characterImage: $CharacterImage)
                        })
                        Button(action: { //OK按鈕
                            if DataComponent.Name == ""{
                                alertMsg = "名字不得為空"
                                showAlert = true
                            }else{
                                Firebase.shared.setUserDisplayName(userDisplayName: DataComponent.Name)
                                let newUser = UserData(Body: DataComponent.Body, Eye: DataComponent.Eye, Hat: DataComponent.Hat, Name: DataComponent.Name, Email: DataComponent.Email, Password: DataComponent.Password, Gender: DataComponent.Gender, Age: Int(DataComponent.Age))
                                Firebase.shared.createUserData(userData: newUser, uid: currentUser!.uid){
                                    (result) in
                                    switch result{
                                    case .success(let successmsg):
                                        print(successmsg)
                                    case .failure(_):
                                        print("上傳錯誤")
                                        showAlertMsg(msg: "發生不明錯誤，請重新嘗試")
                                    }
                                }
                                isGamePage = true
                            }
                        }
                        , label: {
                            Image("circle_ok")
                                .resizable()
                                .frame(width: 70, height: 70)
                        })
                        .alert(isPresented: $showAlert) { () -> Alert in
                            return self.myAlert
                    }
                    }
                    Form{
                        HStack{
                            Image(systemName: "person.circle.fill")
                            Text("名字")
                                .font(.custom("jf-openhuninn-1.1", size: 17))
                                .padding(.trailing)
                            TextField("輸入角色名字", text: $DataComponent.Name)
                        }
                        HStack{
                            Image(systemName: "g.circle.fill")
                            Text("性別")
                                .font(.custom("jf-openhuninn-1.1", size: 17))
                                .padding(.trailing)
                            Picker(selection: $DataComponent.Gender, label: Text("性別")) {
                                ForEach(roles.indices) { (index) in
                                    switch(roles[index]){
                                    case .Male:
                                        Text("男生")
                                    case .Female:
                                        Text("女生")
                                    }
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                        HStack{
                            Image(systemName: "calendar.circle.fill")
                            Text("年齡")
                                .font(.custom("jf-openhuninn-1.1", size: 17))
                                .padding(.trailing)
                            Slider(value: $DataComponent.Age, in: 0...100, step: 1)
                            Text(String(Int(DataComponent.Age)))
                                .font(.custom("jf-openhuninn-1.1", size: 17))
                            }
                    }
                }
            }.background(
                Image("starbackground")
                    .contrast(0.8))
            .fullScreenCover(isPresented: $isGamePage, content: {
            GamePage()
        })
    }
    func showAlertMsg(msg: String) -> Void {
        self.alertMsg = msg
        if alertMsg == "設置基本資料成功" {
            self.myAlert = Alert(title: Text("成功"), message: Text(alertMsg), dismissButton: .default(Text("請重新登入"), action: {
                //FireBase.shared.userSingOut()
                self.presentationMode.wrappedValue.dismiss()}))
            self.showAlert = true
        }
        else {
            self.myAlert = Alert(title: Text("錯誤"), message: Text(alertMsg), dismissButton:
                .cancel(Text("重新輸入")))
            self.showAlert = true
        }
    }
    
}

struct SignupPage_Previews: PreviewProvider {
    static var previews: some View {
        SignupPage()
            .environmentObject(userData())
    }
}
