//
//  UserDataPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/26.
//

import SwiftUI
import FirebaseAuth

struct UserDataPage: View {
    @Binding var isUserDataPage: Bool
    @State private var currentUser = Auth.auth().currentUser
    @State private var currentUserData = UserData(Body: 0, Eye: 0, Hat: 0, Name: "", Email: "", Password: "",Gender: 0, Age: 18)
    var charcterView: some View{
        ZStack{
            Image("body\(currentUserData.Body)")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .offset(x: 0, y: 0)
            Image("eye\(currentUserData.Eye)")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
                .offset(x: 0, y: 0)
            Image("hat\(currentUserData.Hat)")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
                .offset(x: -10, y: -95)
        }.frame(width: 300, height: 300, alignment: .center)
    }
    var body: some View {
        VStack{
            VStack{
                Text("個人資料")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            charcterView
                .border(Color.black, width: 5)
            Form{
                HStack{
                    Image(systemName: "person.circle.fill")
                    Text("名字")
                        .font(.custom("jf-openhuninn-1.1", size: 17))
                        .padding(.trailing)
                    Text(currentUserData.Name)
                        .font(.custom("HanziPenTC-W5", size: 25))
                }
                HStack{
                    Image(systemName: "g.circle.fill")
                    Text("性別")
                        .font(.custom("jf-openhuninn-1.1", size: 17))
                        .padding(.trailing)
                    if(currentUserData.Gender == 0){
                        Text("男生")
                            .font(.custom("HanziPenTC-W5", size: 25))
                    }else{
                        Text("女生")
                            .font(.custom("HanziPenTC-W5", size: 25))
                    }
                }
                HStack{
                    Image(systemName: "calendar.circle.fill")
                    Text("年齡")
                        .font(.custom("jf-openhuninn-1.1", size: 17))
                        .padding(.trailing)
                    Text(String(Int(currentUserData.Age)))
                        .font(.custom("HanziPenTC-W5", size: 25))
                    }
            }
            VStack{
                Spacer()
                Button(action: {
                    isUserDataPage = false
                }, label: {
                    Image("navigation_back")
                        .resizable()
                        .frame(width: 150, height: 75)
                })
                Spacer()
            }
        }.background(
            Image("mountain_background")
                .contrast(0.8))
        .onAppear{
            perform: do {
                       UITableView.appearance().backgroundColor = .clear
                   }
            Firebase.shared.fetchUsers(){ result in
                switch (result) {
                case .success(let dataArray):
                    for i in dataArray {
                        if i.id == currentUser?.uid {
                            currentUserData = i
                            break
                        }
                    }
                case .failure(_):
                    print("抓取失敗")
                }
            }
        }
    }
}
struct UserDataPage_Previews: PreviewProvider {
    static var previews: some View {
        UserDataPage(isUserDataPage: .constant(true))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
