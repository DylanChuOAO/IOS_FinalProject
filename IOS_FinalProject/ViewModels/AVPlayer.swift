//
//  AVPlayer.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/14.
//
import UIKit
import AVFoundation

extension AVPlayer {
    static var bgQueuePlayer = AVQueuePlayer()
    static var bgPlayerLooper: AVPlayerLooper!
    
    static func setupBgMusic(){
        guard let url = Bundle.main.url(forResource: "黃金傳說", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
        let item = AVPlayerItem(url: url)
        bgPlayerLooper = AVPlayerLooper(player: bgQueuePlayer, templateItem: item)
    }
}
