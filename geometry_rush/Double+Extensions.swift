//
//  Double+extension.swift
//  geometry_rush
//
//  Created by ganyi on 2016/10/13.
//  Copyright © 2016年 ganyi. All rights reserved.
//

import Foundation
extension Double{
    static func random(min: UInt32, max: UInt32) -> Double{
        return Double(arc4random_uniform(max - min)) + Double(min)
    }
}
