//
//  Ground.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/14.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class Ground: SCNNode {
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = SCNVector3(0, 0, 0)
        
        categoryBitMask = 0x1 << 0
        
        light?.categoryBitMask = 0x1 << 0
    }
    
    private func createContents(){

        let floor = SCNPlane(width: scene_size!.width, height: scene_size!.height)
    
        geometry = floor

        let material = SCNMaterial()
        material.diffuse.contents = "art.scnassets/grass.jpg"
        material.diffuse.wrapS = .repeat
        material.diffuse.wrapT = .repeat
//        material.isLitPerPixel = false
        material.locksAmbientWithDiffuse = true
        material.diffuse.mipFilter = .linear
        
        material.ambient.contents = UIColor.black
        floor.materials = [material]
        
        //添加物理体
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: floor, options: nil))
        physicsBody?.categoryBitMask = PhysicsMask.ground
        physicsBody?.contactTestBitMask = PhysicsMask.player
        physicsBody?.collisionBitMask = PhysicsMask.player
        physicsBody?.isAffectedByGravity = false 
        physicsBody?.usesDefaultMomentOfInertia = true
    }
}
