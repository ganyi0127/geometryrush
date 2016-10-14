//
//  MainCamera.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class MainCamera: SCNNode {
    
    //摄像机高度
    private let cameraFar: CGFloat = 25000
    
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = SCNVector3(0, 0, cameraFar)
    }
    
    func setLookatTarget(target: SCNNode?){
        
        let lookat = SCNLookAtConstraint(target: target)
        constraints = [lookat]
    }
    
    private func createContents(){
        
        
        let node = SCNCamera()
        camera = node
        camera?.usesOrthographicProjection = false
        
        if camera!.usesOrthographicProjection{
            //正交
            camera?.orthographicScale = Double(view_size.width) / 2

        }else{
            //透视
            camera?.zFar = Double(cameraFar * 1.5)
            camera?.zNear = 20
            let degree: Double = atan(Double(scene_size!.height / cameraFar / 2)) * 2 * 180 / M_PI
            camera?.yFov = degree           //透视角
            
            camera?.focalSize = 100         //焦点范围
            camera?.focalDistance = 200     //焦点距离
            camera?.focalBlurRadius = 3     //模糊度
            camera?.aperture = 0.1          //过度边缘
            camera?.motionBlurIntensity = 0 //移动模糊
            
            camera?.wantsHDR = false        //使用高倍增强
            camera?.exposureOffset = 10     //映射色调调整
            
            camera?.averageGray = 1         //灰度平衡
            camera?.whitePoint = 1          //白平衡
            
            camera?.wantsExposureAdaptation = true  //自动曝光
            camera?.minimumExposure = 1     //最小曝光
            camera?.maximumExposure = 2     //最大曝光
            
            camera?.saturation = 0.5          //饱和度
            camera?.contrast = 0.1            //对比度

            camera?.colorFringeStrength = 5     //色彩边缘效应（艺术效果）
            camera?.colorFringeIntensity = 1    //色彩衰变
            
            camera?.vignettingPower = 0.02  //边缘阴影
            camera?.vignettingIntensity = 5
        }
    }
}
