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
    fileprivate var gameScene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        gameScene = GameScene()
        
        let scnView = view as! SCNView
        scnView.scene = gameScene
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = false
        scnView.backgroundColor = .lightGray
        
        //覆盖层
        if sceneSize == nil{
            sceneSize = scnView.bounds.size
            print(sceneSize)
        }
        let menuScene = MenuScene(size: sceneSize!)
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
        // Release any cached data, images, etc that aren't in use.
    }

}
