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
    static let ground:Int = 0x1 << 2
}

//保存所有enemy
var garbageEnemyList = [Enemy]()

//PLAYER
let player_dropspeed_slow: Float = 1
let player_dropspeed_fast: Float = 2
let enemy_height:CGFloat = 5
let camera_height:CGFloat = 20000
let player_height:CGFloat = camera_height
