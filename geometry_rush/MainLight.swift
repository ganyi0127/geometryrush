//
//  MainLight.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class MainLight: SCNNode {
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = SCNVector3(100, 100, 10)
    }
    
    private func createContents(){
        
        light = SCNLight()
        light?.type = .omni
        light?.categoryBitMask = 0x1 << 0
        light?.color = UIColor.white
    }
}
