//
//  WaitingRoomPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/1.
//

import SwiftUI

struct WaitingRoomPage: View {
    @EnvironmentObject private var UserDataComponent: userData
    @EnvironmentObject private var DataComponent: gameData
    var body: some View {
        VStack{
            VStack{
                Text("等待房間")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            ScrollView{
                HStack{
                    HStack{
                        Text(DataComponent.roomNameString)
                            .font(.custom("jf-openhuninn-1.1", size: 40))
                        +
                        Text("號房")
                            .font(.custom("jf-openhuninn-1.1", size: 40))
                        
                    }.padding()
                    Spacer()
                    Image("clock")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
            ScrollView{
                Text("123")
                //Text(UserDataComponent.Name)
            }
            ScrollView{
                Text("123")
                //Text(UserDataComponent.Name)
            }
        }.background(
            Image("mountain_background")
                .contrast(0.8))
    }
}

struct WaitingRoomPage_Previews: PreviewProvider {
    static var previews: some View {
        WaitingRoomPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
