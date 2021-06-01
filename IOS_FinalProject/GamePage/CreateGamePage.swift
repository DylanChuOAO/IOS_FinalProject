//
//  CreateGamePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/31.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

struct CreateGamePage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var DataComponent: gameData
    @Binding var isCreateGamePage: Bool
    var body: some View {
        VStack{
            VStack{
                Text("建立遊戲")
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
                            Image("building_house1")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .padding()
                        }
                        HStack{
                            Text(DataComponent.roomNameString )
                                .font(.custom("jf-openhuninn-1.1", size: 40))
                                .frame(width: 150, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .background(Color.purple
                                                .blur(radius: 6)
                                                .cornerRadius(20))
                                .padding()
                            Spacer()
                        }
                    }.background(Color.yellow
                                    .blur(radius: 6)
                                    .cornerRadius(20))
                    .padding()
                }
                VStack{
                    Button(action: {
                        let randomNum = Int.random(in: 100000..<1000000)
                        DataComponent.roomNameString = String(randomNum)
                    }, label: {
                        Image("dice")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                                    .frame(width: 220, height: 220)
                            )
                    }).padding()
                    HStack{
                        Button(action: {
                            isCreateGamePage = false
                        }, label: {
                            Image("navigation_back")
                                .resizable()
                                .frame(width: 150, height: 75)
                        }).padding()
                        Button(action: {
                            //出問題的地方 6/1
                            //let newUser = playerData(index: 0,Name: UserDataComponent.Name, Body: UserDataComponent.Body, Eye: UserDataComponent.Eye, Hat: UserDataComponent.Hat)
                            //let newgame = GameData(id: "0", roomNameString: DataComponent.roomNameString, players: playerData(index: 0,Name: UserDataComponent.Name, Body: UserDataComponent.Body, Eye: UserDataComponent.Eye, Hat: UserDataComponent.Hat))
                        }, label: {
                            Image("navigation_next")
                                .resizable()
                                .frame(width: 150, height: 75)
                        }).padding()
                    }.padding()
                }
            }
        }
        .background(
            Image("mountain_background")
                .contrast(0.8))
        .onAppear()
    }
}

struct CreateGamePage_Previews: PreviewProvider {
    static var previews: some View {
        CreateGamePage(isCreateGamePage: .constant(true))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
