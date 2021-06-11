//
//  ViewContoller.swift
//  IOS_FinalProject
//
//  Created by 朱冠儒 on 2021/6/11.
//

import Foundation
import UIKit

/*class ViewController: UIViewController {
 var blackORwhite: Bool!
 override func viewDidLoad() {
     super.viewDidLoad()
     self.view.backgroundColor = UIColor.lightGray
     blackORwhite = true
     makeQiPan()
 }
 //做棋盤
 private func makeQiPan() {
     var lineNumHor : Int //水平
     var lineNumShow : Int //垂直
     lineNumHor = (Int(UIScreen.main.bounds.size.height) - 64 )/30 + 1
     lineNumShow = (Int(UIScreen.main.bounds.size.width - 15 )/30 ) + 1
     //水平線
     for i in 0...(lineNumHor - 1) {
         let lineHoral : UIView!
         lineHoral = UIView.init()
         // lineHoral.frame = CGRectMake(15, 64 + CGFloat(Float(i*30)), CGFloat(Float(lineNumShow*30)) - 30 , 1)
         lineHoral.frame = CGRect(x: 15, y: 64 + CGFloat(Float(i*30)), width: CGFloat(Float(lineNumShow * 30)) - 30 , height: 1)
         lineHoral.backgroundColor = UIColor.black
         self.view .addSubview(lineHoral)
     }
     //垂直線
     for i in 0...(lineNumShow - 1) {
         //垂直線
         let lineShow : UIView!
         lineShow = UIView.init()
         //lineShow.frame = CGRectMake(15 + CGFloat(Float(i*30)), 64, 1, CGFloat(Float(lineNumHor!*30)) - 30)
         lineShow.frame = CGRect(x: 15 + CGFloat(Float(i*30)), y: 64, width: 1, height: CGFloat(Float(lineNumHor*30)) - 30)
         lineShow.backgroundColor = UIColor.black
         self.view .addSubview(lineShow)
     }
 }
 override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {// 觸摸 觸發事件
     //touch 位置
     var touch : UITouch!
     touch = touches.first
     var touchPoint : CGPoint!
     touchPoint = touch.location(in: self.view)
     print("\(touchPoint.x)")
     if touchPoint.y < 60 {
         return;
     }
     var myView : UIView!
     myView = UIView.init()
     //交叉點
     var xPoint : Int!
     var yPoint : Int!
     xPoint = (Int(touchPoint.x) - 15) % 30
     //x
     if xPoint > 15 {
         xPoint = ((Int(touchPoint.x) - 15)/30)*30 + 15 + 30 - 10
     }else {
         xPoint = ((Int(touchPoint.x) - 15)/30)*30 + 15 - 10
     }
     //y
     yPoint = (Int(touchPoint.y) - 64 )%30
     if yPoint > 15 {
         yPoint = ((Int(touchPoint.y) - 64)/30)*30 + 64 + 30 - 10
     }else {
         yPoint = ((Int(touchPoint.y) - 64)/30)*30 + 64 - 10
     }
     myView.frame = CGRect(x: CGFloat(Float(xPoint)), y: CGFloat(Float(yPoint)), width: 20, height: 20)
     myView.layer.masksToBounds = true
 }
}*/
/*import UIKit
 
 
 
 class ViewController: UIViewController {
  
  
  
     var blackOrWhite : Bool!//用于交替下子
  
     override func viewDidLoad() {
  
         super.viewDidLoad()
  
         self.view.backgroundColor = UIColor.lightGrayColor()
  
         blackOrWhite = true
  
         makeQiPan()//做五子棋的棋盘
  
         // Do any additional setup after loading the view, typically from a nib.
  
     }
  
  
  
     //做棋盘
  
     private func makeQiPan() {
  
         
  
         var lineNumHor : Int?//水平线的个数
  
         lineNumHor =  (Int(UIScreen.mainScreen().bounds.size.height) - 64 )/30 + 1
  
         
  
         //树脂的
  
         var lineNumShow : Int //竖直线的个数
  
         lineNumShow = (Int(UIScreen.mainScreen().bounds.size.width - 15 )/30 ) + 1
  
         
  
         for var i = 0 ; i < lineNumHor ; i++ {//水平线
  
             let lineHoral : UIView!
  
             lineHoral = UIView.init()
  
             lineHoral.frame = CGRectMake(15, 64 + CGFloat(Float(i*30)), CGFloat(Float(lineNumShow*30)) - 30 , 1)
  
             lineHoral.backgroundColor = UIColor.blackColor()
  
             self.view .addSubview(lineHoral)
  
         }
  
         
  
         for var i = 0; i < lineNumShow; i++ {//竖直线
  
             let lineShow : UIView!
  
             lineShow = UIView.init()
  
             lineShow.frame = CGRectMake(15 + CGFloat(Float(i*30)), 64, 1, CGFloat(Float(lineNumHor!*30)) - 30)
  
             lineShow.backgroundColor = UIColor.blackColor()
  
             self.view .addSubview(lineShow)
  
         }
  
         
  
         
  
     }
  
     
  
     override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {// 触摸事件的触发
  
         //获得触摸的位置
  
         var touch : UITouch!
  
         touch = touches.first
  
         var touchPoint : CGPoint!
  
         touchPoint = touch.locationInView(self.view)
  
         print("\(touchPoint.x)")
  
         
  
         if touchPoint.y < 60 {
  
             return;
  
         }
  
         
  
         var myView : UIView!
  
         myView = UIView.init()
  
         
  
         //规整触摸的位置在棋盘的交叉点
  
         var xPoint : Int!
  
         var yPoint : Int!
  
         xPoint = (Int(touchPoint.x) - 15 )%30
  
         if xPoint > 15 {
  
             xPoint = ((Int(touchPoint.x) - 15)/30)*30 + 15 + 30 - 10
  
         }else{
  
             xPoint = ((Int(touchPoint.x) - 15)/30)*30 + 15 - 10
  
         }
  
         yPoint = (Int(touchPoint.y) - 64 )%30
  
         if yPoint > 15 {
  
             yPoint = ((Int(touchPoint.y) - 64)/30)*30 + 64 + 30 - 10
  
         }else{
  
             yPoint = ((Int(touchPoint.y) - 64)/30)*30 + 64 - 10
  
         }
  
         
  
         myView.frame = CGRectMake(CGFloat(Float(xPoint)), CGFloat(Float(yPoint)), 20, 20)
  
         myView.layer.masksToBounds = true
  
         myView.layer.cornerRadius = 10
  
         if (blackOrWhite != nil) {//判断是白色子还是红色的字儿
  
             myView.backgroundColor = UIColor.blackColor()
  
             blackOrWhite = nil
  
         }else {
  
             myView.backgroundColor = UIColor.whiteColor()
  
             blackOrWhite = true
  
         }
  
         self.view.addSubview(myView)//添加这个子儿
         
  
     }
  
     override func didReceiveMemoryWarning() {
  
         super.didReceiveMemoryWarning()
  
         // Dispose of any resources that can be recreated.
  
     }
  
  
  
  
  

 ————————————————
 版权声明：本文为CSDN博主「ios攻城狮2014」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
 原文链接：https://blog.csdn.net/qq_35122556/article/details/80020337*/
