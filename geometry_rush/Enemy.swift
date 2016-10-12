//
//  Enemy.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class Enemy: SCNNode {
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        let point = getRandomPosition(byBoxRadius: 1)
        position = SCNVector3(point.x, point.y, 0)
        
    }
    
    private func createContents(){
        
        geometry = SCNBox(width: 5, height: 5, length: 5, chamferRadius: 15)
        
        let meterial = geometry?.firstMaterial
        meterial?.diffuse.contents = UIColor.blue
        
        //添加随机移动动画
        let targetPoint = getRandomPosition(byBoxRadius: 1)
        addMovingAnimation(targetPoint: targetPoint)
    }
    
    private func addMovingAnimation(targetPoint point: CGPoint){
        
        let vector = SCNVector3(point.x, point.y, 0)
        let duration = Double(arc4random_uniform(40)) / 10 + 0.5
        let mvAct = SCNAction.move(to: vector, duration: duration)
        let rmAct = SCNAction.removeFromParentNode()
        let seqAct = SCNAction.sequence([mvAct, rmAct])
        runAction(seqAct)
        
        
    }
}
