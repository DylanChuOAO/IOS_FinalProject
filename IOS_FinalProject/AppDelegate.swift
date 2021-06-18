//
//  AppDelegate.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/5/18.
//

import UIKit
import Firebase
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        AVPlayer.setupBgMusic()
        AVPlayer.bgQueuePlayer.play()
        
        return true
    }
}
