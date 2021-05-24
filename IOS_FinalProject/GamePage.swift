//
//  ContinuePage.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/10.
//

import SwiftUI

struct GamePage: View {
    var body: some View {
        Text("Game Page")
    }
}

struct ContinuePage_Previews: PreviewProvider {
    static var previews: some View {
       GamePage()
        .environmentObject(userData())
    }
}
