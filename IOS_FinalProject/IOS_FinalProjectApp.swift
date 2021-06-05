//
//  IOS_FinalProjectApp.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/4/28.
//

import SwiftUI

@main
struct IOS_FinalProjectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var UserDataComponent = userData()
    @StateObject private var GameDataComponent = gameData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserDataComponent)
                .environmentObject(GameDataComponent)
        }
    }
}
