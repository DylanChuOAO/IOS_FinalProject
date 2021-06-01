//
//  JoinGamePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct JoinGamePage: View {
    @EnvironmentObject private var DataComponent: gameData
    @Binding var isJoinGamePage: Bool
    var body: some View {
        VStack{
            VStack{
                Text("加入遊戲")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            VStack{
                ScrollView{
                    VStack{
                        HStack{
                            Text("房號")
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                                .padding()
                            Spacer()
                            Image("mark_key")
                                .padding()
                        }
                        HStack{
                            TextField(" 輸入房名", text: $DataComponent.roomNameString)
                                .frame(width: 150, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.yellow
                                                .blur(radius: 6)
                                                .cornerRadius(20))
                                .padding()
                            Spacer()
                        }
                    }.background(Color.purple
                                    .blur(radius: 6)
                                    .cornerRadius(20))
                    .padding()
                }
                HStack{
                    Button(action: {
                        isJoinGamePage = false
                    }, label: {
                        Image("navigation_back")
                            .resizable()
                            .frame(width: 150, height: 75)
                    }).padding()
                    Button(action: {
                    }, label: {
                        Image("navigation_next")
                            .resizable()
                            .frame(width: 150, height: 75)
                    }).padding()
                }.padding()
            }
        }.background(
            Image("mountain_background")
                .contrast(0.8))
    }
}

struct JoinGamePage_Previews: PreviewProvider {
    static var previews: some View {
        JoinGamePage(isJoinGamePage: .constant(true))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
