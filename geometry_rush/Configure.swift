//
//  Configure.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import UIKit

//尺寸
var scene_size:CGSize?
var view_size = UIScreen.main.bounds.size

//消息中心
let notify = NotificationCenter.default

let notify_move = Notification.Name("move")
let notify_restart = Notification.Name("restart")
let notify_active = Notification.Name("active")

//physicsMask
struct PhysicsMask{
    static let player:Int = 0x1 << 0
    static let enemy:Int = 0x1 << 1
}

//保存所有enemy
var garbageEnemyList = [Enemy]()

//PLAYER
let player_height:CGFloat = 200
let camera_height:CGFloat = 200
