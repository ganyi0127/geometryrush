//
//  Player.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class Player: SCNNode {
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
    }
    
    private func createContents(){
        
        geometry = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 15)
        
        let meterial = geometry?.firstMaterial
        meterial?.diffuse.contents = UIColor.red
        meterial?.ambient.contents = UIColor.green
        
    }
}
