//
//  MainCamera.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/12.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import SceneKit
class MainCamera: SCNNode {
    override init() {
        super.init()
        
        config()
        createContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        
        position = SCNVector3(0, 0, 50)
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
            camera?.xFov = -Double(scene_size!.width)
            camera?.yFov = -Double(scene_size!.height)
        }

    }
}
