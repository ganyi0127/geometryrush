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
    
    var isVisualCentre = false{
        didSet{
            
            if isVisualCentre != oldValue{
                
                setVisualCentre(enable: isVisualCentre)
            }
        }
    }
    
    private var cameraNode: SCNNode?
    
    //MARK:- init
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
        
        position = SCNVector3(0, 0, player_height)
        
        notify.addObserver(self, selector: #selector(setPosition(notification:)), name: notify_move, object: nil)
        
        //设置自身视角
        setVisualCentre(enable: true)
    }
    
    private func createContents(){
        
        geometry = SCNBox(width: radius, height: radius, length: radius, chamferRadius: radius / 2)
        
        let meterial = geometry?.firstMaterial
        meterial?.diffuse.contents = UIColor.red
        meterial?.ambient.contents = UIColor.green
     
        //添加物理体
        physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: geometry!, options: nil))
        physicsBody?.categoryBitMask = PhysicsMask.player
        physicsBody?.contactTestBitMask = PhysicsMask.enemy
        physicsBody?.collisionBitMask = PhysicsMask.ground
        physicsBody?.isAffectedByGravity = false
        physicsBody?.usesDefaultMomentOfInertia = true      //惯性
        
        //添加外力
//        physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: -900), asImpulse: true)
    }
    
    //MARK:- spriteKit层滑动回调
    func setPosition(notification: Notification){
        
        guard let pos = notification.object as? CGVector else {
            return
        }
        
        guard let size = scene_size else {
            return
        }

        let oldPosX = position.x
        let oldPosY = position.y
        
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
        
        position.x = newPosX
        position.y = newPosY
    }
    
    //手动下落
    func drop(){

        let newPosZ = position.z - player_dropspeed_fast * 10
        position.z = newPosZ
        
    }
    
    //手动设置
    func setPosition(deltaVector vector: CGVector){
        
        let oldPosX = position.x
        let oldPosY = position.y
        let oldPosZ = position.z
        position = SCNVector3(oldPosX + Float(vector.dx), oldPosY + Float(vector.dy), oldPosZ)
    }
    
    //设置为主视角
    private func setVisualCentre(enable: Bool){
        if enable{
            
            let ownCamera = SCNCamera()
            
            cameraNode = SCNNode()
            cameraNode?.camera = ownCamera
            cameraNode?.position = SCNVector3(0, 0, 5000)
            self.addChildNode(cameraNode!)
            
            ownCamera.usesOrthographicProjection = false
            
            
            if ownCamera.usesOrthographicProjection{
                //正交
                ownCamera.orthographicScale = Double(view_size.width) / 2
                
            }else{
                //透视
                ownCamera.zFar = Double(camera_height * 1.5)
                ownCamera.zNear = 20
                let degree: Double = atan(Double(scene_size!.height / camera_height / 2)) * 2 * 180 / M_PI
                ownCamera.yFov = degree           //透视角
                
                ownCamera.focalSize = 100         //焦点范围
                ownCamera.focalDistance = 200     //焦点距离
                ownCamera.focalBlurRadius = 3     //模糊度
                ownCamera.aperture = 0.1          //过度边缘
                ownCamera.motionBlurIntensity = 0 //移动模糊
                
                ownCamera.wantsHDR = false        //使用高倍增强
                ownCamera.exposureOffset = 10     //映射色调调整
                
                ownCamera.averageGray = 1         //灰度平衡
                ownCamera.whitePoint = 1          //白平衡
                
                ownCamera.wantsExposureAdaptation = true  //自动曝光
                ownCamera.minimumExposure = 1     //最小曝光
                ownCamera.maximumExposure = 2     //最大曝光
                
                ownCamera.saturation = 0.5          //饱和度
                ownCamera.contrast = 0.1            //对比度
                
                ownCamera.colorFringeStrength = 5     //色彩边缘效应（艺术效果）
                ownCamera.colorFringeIntensity = 1    //色彩衰变
                
                ownCamera.vignettingPower = 0.02  //边缘阴影
                ownCamera.vignettingIntensity = 5
            }
        }else{
            cameraNode?.removeFromParentNode()
            cameraNode = nil
        }
    }
}
