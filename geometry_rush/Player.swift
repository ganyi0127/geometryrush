//
//  Player.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class Player: SCNNode {
    
    private let radius:CGFloat = 5
    
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        notify.removeObserver(self, name: notify_move, object: nil)
    }
    
    private func config(){
        
        position = SCNVector3(0, 0, 0)
        
        notify.addObserver(self, selector: #selector(setPosition(notification:)), name: notify_move, object: nil)
    }
    
    private func createContents(){
        
        geometry = SCNBox(width: radius, height: radius, length: radius, chamferRadius: radius / 2)
        
        let meterial = geometry?.firstMaterial
        meterial?.diffuse.contents = UIColor.red
        meterial?.ambient.contents = UIColor.green
     
        //添加物理体
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        physicsBody?.categoryBitMask = PhysicsMask.player
        physicsBody?.contactTestBitMask = PhysicsMask.enemy

    }
    
    func setPosition(notification: Notification){
        
        guard let pos = notification.object as? CGVector else {
            return
        }
        
        guard let size = scene_size else {
            return
        }

        let oldPosX = position.x
        let oldPosY = position.y
        let oldPosZ = position.z
        
        var newPosX = oldPosX + Float(pos.dx)
        if newPosX < Float(-size.width / 2 + radius / 2){
            newPosX = Float(-size.width / 2 + radius / 2)
        }else if newPosX > Float(size.width / 2 - radius / 2){
            newPosX = Float(size.width / 2 - radius / 2)
        }
        
        var newPosY = oldPosY + Float(pos.dy)
        if newPosY < Float(-size.height / 2 + radius / 2){
            newPosY = Float(-size.height / 2 + radius / 2)
        }else if newPosY > Float(size.height / 2 - radius / 2){
            newPosY = Float(size.height / 2 - radius / 2)
        }
        position = SCNVector3(newPosX, newPosY, oldPosZ)
    }
    
    //手动设置
    func setPosition(deltaVector vector: CGVector){
        
        let oldPosX = position.x
        let oldPosY = position.y
        let oldPosZ = position.z
        position = SCNVector3(oldPosX + Float(vector.dx), oldPosY + Float(vector.dy), oldPosZ)
    }
}
