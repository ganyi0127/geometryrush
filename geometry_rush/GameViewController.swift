//
//  GameViewController.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

    //3d场景层
    var scnView: SCNView!
    var gameScene: GameScene!
    
    //MARK:- init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scnView = view as! SCNView
        if scene_size == nil{
            scene_size = scnView.bounds.size
        }
        
        gameScene = GameScene()
        scnView.scene = gameScene
        
        scnView.delegate = self     //更新函数代理
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = false
        scnView.backgroundColor = .lightGray
        
        //覆盖层
        let menuScene = MenuScene(size: scene_size!)
        scnView.overlaySKScene = menuScene
        
        //点击事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }

    
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
        let scnView = self.view as! SCNView
        
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
        
            let result: AnyObject = hitResults[0]
            
            let material = result.node!.geometry!.firstMaterial!
            
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK:- render delegate
extension GameViewController: SCNSceneRendererDelegate{
    
    //MARK:- roop
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        guard gameScene.isActive else {
            return
        }

        //发射
        sendEnemy()
    }
    
    //MARK:- 发射
    private func sendEnemy(){
        
        let rand = arc4random_uniform(2)
        if rand == 0{
            return
        }
        
        let startPoint = GameScene.getRandomPosition(byBoxRadius: 1)
        let endPoint = GameScene.getRandomPosition(byBoxRadius: 1)
        
        if startPoint.x == endPoint.x || startPoint.y == endPoint.y{
            return
        }
        
        var enemy: Enemy
        if garbageEnemyList.isEmpty{
            enemy = Enemy()
        }else{
            enemy = garbageEnemyList.removeFirst()
        }

        enemy.setMoveAction(fromStartPoint: startPoint, frameEndPoint: endPoint){
            garbageEnemyList.append(enemy)
        }
        gameScene.rootNode.addChildNode(enemy)
    }
}
