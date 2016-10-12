//
//  Configure.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import UIKit

//尺寸
var sceneSize:CGSize?


//MAKR:- 随机获取包围点
func getRandomPosition(byBoxRadius radius: CGFloat) -> CGPoint{
   
    guard let size = sceneSize else {
        return CGPoint.zero
    }
    
    //随机4面
    let rand = arc4random_uniform(4)
    
    var posX: CGFloat!
    var posY: CGFloat!
    
    if [0, 1].contains(rand){
        posX = CGFloat(arc4random_uniform(UInt32(size.width + radius))) - radius
        if rand == 0{
            //上
            posY = size.height + radius
        }else{
            //下
            posY = -radius
        }
    }else{
        posY = CGFloat(arc4random_uniform(UInt32(size.height + radius))) - radius
        if rand == 3{
            //左
            posX = -radius
        }else{
            //右
            posX = size.width + radius
        }
    }
    posY = posY - size.height / 2
    posX = posX - size.width / 2
    return CGPoint(x: posX, y: posY)
}
