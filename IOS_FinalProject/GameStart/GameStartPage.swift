//
//  GameStartPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/1.
//

import SwiftUI

struct GameStartPage: View {
    /*var charcterView: some View{
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
 }*/
    @State private var UIColor = Color(red: 238/255, green: 186/255, blue: 85/255)
    @State private var UIColor2 = Color(red: 32/255, green: 114/255, blue: 69/255)
    var chessBackView: some View{
        ZStack{
            Circle()
                .foregroundColor(UIColor2)
                .frame(width: 77, height: 77, alignment: .center)
            //Image("1280px-Xiangqi_ad1.svg")
              //  .resizable()

        }.frame(width: 88, height: 80, alignment: .center)
        .border(Color.black)
    }
    struct clickChess {
        
    }
    var body: some View {
        VStack{
            HStack{
                
                Text("遊戲開始")
                    .font(.custom("HanziPenTC-W5", size: 50))
            }.padding(.vertical)
            VStack{
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        chessBackView
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        chessBackView
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        chessBackView
                    })
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        chessBackView
                    })
               }
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessBackView
                     })
                     Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                         chessBackView
                     })
                     Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                         chessBackView
                     })
                     Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                         chessBackView
                     })
                }
                Spacer()
            }
            
            .background(UIColor)
            .padding()
        }.background(
            Image("mountain_background")
                .contrast(0.8))
    }
}

struct GameStartPage_Previews: PreviewProvider {
    static var previews: some View {
        GameStartPage()
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
