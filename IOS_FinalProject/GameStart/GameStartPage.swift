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
    var chessView: some View{
        ZStack{
            Image("1280px-Xiangqi_ad1.svg")
                .resizable()
                .frame(width: 70, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

        }.frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        
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
                    chessView
                    })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    chessView
                        
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    chessView
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    chessView
                })
               }
                HStack{
                    Button(action: {}, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                HStack{
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                     })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                         
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                 Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                     chessView
                 })
                }
                Spacer()
            }.background(
                Image("chessboard")
                    .resizable()
                    .contrast(0.8))
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
