//
//  Data.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/4/28.
//

import Foundation

enum Gender: Int, Decodable{
    case Male = 0
    case Female = 1
}

enum BodyColor: Int, Decodable{
    case 紅色 = 0
    case 黃色 = 1
    case 白色 = 2
    case 深藍色 = 3
    case 紫色 = 4
}
//["紅色", "黑色", "白色", "深藍色", "紫色", "淺藍色", "黃色", "粉紅色", "橘色", "深綠色", "淺綠色", "咖啡色"]



/*struct picComponent: Codable, Identifiable{
    var id = UUID()
    var currentBody: Int
    var currentEye: Int
    var currentHat: Int
    var username: String
    var gender: Int
    var age: Int
}
*/


