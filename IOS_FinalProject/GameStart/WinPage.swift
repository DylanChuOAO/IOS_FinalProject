//
//  WinPage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/11.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import FirebaseStorageSwift
struct WinPage: View {
    @State private var isGamePage = false
    var body: some View {
        Button(action: {
            isGamePage = true
        }, label: {
            Text("Button")
        }).fullScreenCover(isPresented: $isGamePage, content: {
            GamePage()
        })
    }
}
struct WinPage_Previews: PreviewProvider {
    static var previews: some View {
        WinPage()
    }
}
