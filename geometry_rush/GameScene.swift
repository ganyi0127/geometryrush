//
//  GameScene.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class GameScene: SCNScene {
    
    //主Ball
    var player: Player?
    
    //暂停于运行
    var isActive = false{
        didSet{
            if isActive{
                reset(moveChilds: true)
            }else{
                reset(moveChilds: false)
            }
        }
    }
    
    //MARK:- init
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    deinit {
        notify.removeObserver(self, name: notify_restart, object: nil)
        notify.removeObserver(self, name: notify_active, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        physicsWorld.gravity = SCNVector3(0, 0, -900.8)
        physicsWorld.contactDelegate = self
        
        notify.addObserver(self, selector: #selector(resetNotify), name: notify_restart, object: nil)
        notify.addObserver(self, selector: #selector(start(notification:)), name: notify_active, object: nil)
    }
    
    private func createContents(){
        
        //add player
        player = Player()
        rootNode.addChildNode(player!)
        
        //add ground
        let ground = Ground()
        rootNode.addChildNode(ground)
        
//        let mainCamera = MainCamera()
//        mainCamera.setLookatTarget(target: player)
//        rootNode.addChildNode(mainCamera)
        
        let mainLight = MainLight()
//        mainLight.setLookatTarget(target: player)
        rootNode.addChildNode(mainLight)
        
        let ambientLight = AmbientLight()
        rootNode.addChildNode(ambientLight)
        
        //test
//        let p0 = Player()
//        p0.position = SCNVector3(-160, 284, 0)
//        rootNode.addChildNode(p0)
//        let p1 = Player()
//        p1.position = SCNVector3(160, 284, 0)
//        rootNode.addChildNode(p1)
//        let p2 = Player()
//        p2.position = SCNVector3(-160, -284, 0)
//        rootNode.addChildNode(p2)
//        let p3 = Player()
//        p3.position = SCNVector3(160, -284, 0)
//        rootNode.addChildNode(p3)
        
        //test box 柱子
        let testGeometry = SCNBox(width: 10, height: 10, length: 20000, chamferRadius: 3)
        testGeometry.firstMaterial?.diffuse.contents = UIColor.purple
        let test = SCNNode(geometry: testGeometry)
        test.categoryBitMask = 0x1 << 0
        test.light?.categoryBitMask = 0x1 << 0
        test.position = SCNVector3(50, 50, 10000)
        rootNode.addChildNode(test)
        
        //添加物理体
        test.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: testGeometry, options: nil))
        test.physicsBody?.categoryBitMask = PhysicsMask.ground
        test.physicsBody?.contactTestBitMask = PhysicsMask.player
        test.physicsBody?.collisionBitMask = PhysicsMask.player
        test.physicsBody?.isAffectedByGravity = false
        test.physicsBody?.usesDefaultMomentOfInertia = true
    }

    @objc private func resetNotify(){
        isActive = true
    }
    
    //MARK:- 重置 : 移除本身 或 移除动作
    private func reset(moveChilds: Bool){
        
        if moveChilds{
            removeAllEnemys()
        }else{
            removeEnemysAction()
        }
    }
    
    //MARK:- 移除动作
    private func removeEnemysAction(){
        rootNode.childNodes.forEach(){
            childNode in
            if childNode.isKind(of: Enemy.self){
                
                childNode.removeAllActions()
            }
        }
    }
    
    //MARK:- 移除所有enemy
    private func removeAllEnemys(){
        
        rootNode.childNodes.forEach(){
            childNode in
            
            if childNode.isKind(of: Enemy.self){
                childNode.removeFromParentNode()
                garbageEnemyList.append(childNode as! Enemy)
            }
        }
    }
    
    //MARK:- 开始
    @objc fileprivate func start(notification: Notification){
        
        guard let active = notification.object as? Bool else {
            return
        }
        isActive = active
    }
    
    //MARK:- 结束
    fileprivate func gameover(){
        
        isActive = false
        
        player?.position.z = Float(enemy_height)
        
        notify.post(name: notify_active, object: isActive)  //发送结束消息
    }
}

//MARK:- class funcation find point from loop
extension GameScene{
    
    //MAKR:- 随机获取包围点
    class func getRandomPosition(byBoxRadius radius: CGFloat) -> CGPoint{
        
        guard let size = scene_size else {
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
}

extension GameScene: SCNPhysicsContactDelegate{
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {

        var bodyA: SCNPhysicsBody
        var bodyB: SCNPhysicsBody
        
        if contact.nodeA.categoryBitMask > contact.nodeB.categoryBitMask{
            bodyA = contact.nodeB.physicsBody!
            bodyB = contact.nodeA.physicsBody!
        }else{
            bodyA = contact.nodeA.physicsBody!
            bodyB = contact.nodeB.physicsBody!
        }
        
        if bodyA.categoryBitMask == PhysicsMask.player && bodyB.categoryBitMask == PhysicsMask.enemy{
            //game over
            if isActive {
                gameover()
            }
        }else if bodyA.categoryBitMask == PhysicsMask.player && bodyB.categoryBitMask == PhysicsMask.ground{
            if isActive{
                //着地
                print("loading ground")
                gameover()
            }
        }
    }
}
