//
//  MenuScene.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SpriteKit
import SceneKit
class MenuScene: SKScene {
    
    //运行
    private var isActive = false{
        didSet{
            if isActive{
                preciseTime = nil
                survivalTime = 0
            }
        }
    }
    
    private let scoreLabel = {
        () -> SKLabelNode in
        
        let label = SKLabelNode()
        label.fontSize = 30
        label.position = CGPoint(x: 0, y: scene_size!.height - label.fontSize)
        label.horizontalAlignmentMode = .left
        label.text = "0"
        label.color = UIColor.red
        return label
    }()
    
    private var preciseTime: TimeInterval?  //临时变量
    
    fileprivate var survivalTime: TimeInterval = 0{
        didSet{
            
            let surTime = round(survivalTime * 100) / 100
            scoreLabel.text = "\(surTime)"
        }
    }
    
    //MARK:- init
    override init(size: CGSize) {
        super.init(size: size)
        
        config()
        createContents()
    }
    
    deinit {
        notify.removeObserver(self, name: notify_active, object: nil)
        notify.removeObserver(self, name: notify_restart, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        scaleMode = .aspectFill
        
        notify.addObserver(self, selector: #selector(receiveActive(notification:)), name: notify_active, object: nil)
        notify.addObserver(self, selector: #selector(receiveRestart(notification:)), name: notify_restart, object: nil)
    }
    
    private func createContents(){
        
        let button = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        button.position = CGPoint(x: scene_size!.width - 25, y: scene_size!.height - 25)
        button.name = "restart"
        addChild(button)
        
        addChild(scoreLabel)
    }
    
    @objc private func receiveActive(notification: Notification){
     
        guard let active = notification.object as? Bool else {
            return
        }
     
        isActive = active
    }
    
    @objc private func receiveRestart(notification: Notification){
        isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        touches.forEach(){
            touch in
            
            //开始
            if !isActive{
                //do not know why?
                notify.post(name: notify_active, object: true)
                return
            }
            
            //点击
            let location = touch.location(in: self)
            let sprites = nodes(at: location)
           
            if let sprite = sprites.first{
                if sprite.name == "restart"{
                    //restart
                    notify.post(name: notify_restart, object: nil)
                }
            }
        }
    }
    
    //MARK:- 控制移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        guard isActive else {
            return
        }
        
        touches.forEach(){
            touch in
            
            let curLocation = touch.location(in: self)
            let preLocation = touch.previousLocation(in: self)
            
            let delta = CGVector(dx: curLocation.x - preLocation.x, dy: curLocation.y - preLocation.y)

            notify.post(name: notify_move, object: delta)
        }
    }
    
    //MARK:- 渲染
    override func update(_ currentTime: TimeInterval) {
      
        guard isActive else {
            return
        }
        
        guard let preTime = preciseTime else {
            preciseTime = currentTime
            return
        }
        
        let deltaTime = currentTime - preTime
        survivalTime += deltaTime
        
        preciseTime = currentTime
    }
}
