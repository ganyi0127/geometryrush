//
//  Enemy.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class Enemy: SCNNode {
    
    private let radius: CGFloat = 5
    
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
    }
    
    private func createContents(){
        
        geometry = SCNBox(width: radius, height: radius, length: radius, chamferRadius: radius)
        
        let meterial = geometry?.firstMaterial
        meterial?.diffuse.contents = UIColor.blue
        
        //添加物理效果
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        physicsBody?.categoryBitMask = PhysicsMask.enemy
        physicsBody?.contactTestBitMask = PhysicsMask.player
        
    }
    
    //设置动画
    func setMoveAction(fromStartPoint startPoint: CGPoint, frameEndPoint endPoint: CGPoint, closure: @escaping ()->()){
        
        removeAllActions()
        
        //设置起始点
        position = SCNVector3(startPoint.x, startPoint.y, 0)
        
        //设置结束点
        addMovingAnimation(targetPoint: endPoint, closure: closure)
    }
    
    private func addMovingAnimation(targetPoint point: CGPoint, closure: @escaping ()->()){
        
        let vector = SCNVector3(point.x, point.y, 0)
        let duration = Double.random(min: 4, max: 8)
        let mvAct = SCNAction.move(to: vector, duration: duration)
        let rmAct = SCNAction.removeFromParentNode()
        let seqAct = SCNAction.sequence([mvAct, rmAct])
        runAction(seqAct, completionHandler: closure)
    }
}
