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
        
        position = SCNVector3(0, 0, 200)
    }
    
    func setLookatTarget(target: SCNNode?){
        
        let lookat = SCNLookAtConstraint(target: target)
        constraints = [lookat]
    }
    
    private func createContents(){
        
        light = SCNLight()
        light?.type = .directional
        light?.categoryBitMask = 0x1 << 0
        
        light?.color = UIColor.init(red: 0.9, green: 0.8, blue: 0.85, alpha: 1) //光色调
        light?.zFar = 20000
        
        light?.castsShadow = true               //开启投影
        light?.shadowRadius = 1                 //投影边缘模糊
        light?.shadowColor = UIColor.black      //投影颜色
        light?.shadowMapSize = CGSize(width: 10, height: 10)
//        light?.shadowMode = .deferred           //投影模式
        
        
//        light?.temperature = 0.1      //色温
        light?.intensity = 5000    //光亮度
        
        light?.attenuationStartDistance = 150   //开始衰减距离
        light?.attenuationEndDistance = 250     //停止衰减距离
        light?.attenuationFalloffExponent = 5  //衰减量
    }
}
