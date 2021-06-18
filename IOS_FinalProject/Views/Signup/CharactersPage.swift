//
//  CharactersPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/6.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift

extension View{
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct CharactersPage: View {
    @EnvironmentObject var DataComponent: userData
    // (x:-10,y-95)(width: 80, height: 80)
    @Binding var isCharacters: Bool
    @Binding var characterImage: UIImage
        //["紅色", "黑色", "白色", "深藍色", "紫色", "淺藍色", "黃色", "粉紅色", "橘色", "深綠色", "淺綠色", "咖啡色"]
    var charcterView: some View{
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
                Text("創建角色")
                    .font(.custom("HanziPenTC-W5", size: 50))
                    .foregroundColor(Color.white)
                charcterView
                    .border(Color.white, width: 5)
                Spacer()
                //.frame(height: 500)
                HStack{
                    Button(action: {
                        DataComponent.Body = Int.random(in: 0..<5)
                        DataComponent.Eye = Int.random(in: 0..<2)
                        DataComponent.Hat = Int.random(in: 0..<5)
                        //Random
                    }, label: {
                        Image("dice")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 3)
                                    .frame(width: 90, height: 90)
                            )
                    })
                    .padding()
                    Button(action: {
                            isCharacters = false
                        characterImage = charcterView.snapshot()
                    }
                           , label: {
                        Image("circle_ok")
                            .resizable()
                            .frame(width: 100, height: 100)
                            
                    })
                }
                Form{
                    HStack{
                        Text("身體")
                            .font(.custom("jf-openhuninn-1.1", size: 17))
                            .padding(.trailing)
                        Picker(selection: $DataComponent.Body, label: Text("身體")
                        ){
                            Text("紅色").tag(0)
                            Text("黃色").tag(1)
                            Text("白色").tag(2)
                            Text("深藍色").tag(3)
                            Text("紫色").tag(4)
                            //無,餐巾,葉子,櫻桃,怪獸
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack{
                        Text("眼睛")
                            .font(.custom("jf-openhuninn-1.1", size: 17))
                            .padding(.trailing)
                        Picker(selection: $DataComponent.Eye, label: Text("眼睛")
                        ){
                            Text("有反光")
                                .font(.custom("jf-openhuninn-1.1", size: 17))
                                .tag(0)
                            Text("無反光").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    HStack{
                        Text("帽子")
                            .font(.custom("jf-openhuninn-1.1", size: 17))
                            .padding(.trailing)
                        Picker(selection: $DataComponent.Hat, label: Text("眼睛")
                        ){
                            Text("無").tag(0)
                            Text("餐巾").tag(1)
                            Text("葉子").tag(2)
                            Text("櫻桃").tag(3)
                            Text("怪獸").tag(4)
                            //無,餐巾,葉子,櫻桃,怪獸
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }.background(
                Image("starbackground")
                    .contrast(0.8))
            
    }
}

struct CharactersPage_Previews: PreviewProvider {
    static var previews: some View {
        CharactersPage(isCharacters: .constant(true), characterImage: .constant(UIImage()))
            .environmentObject(userData())
            .environmentObject(gameData())
    }
}
