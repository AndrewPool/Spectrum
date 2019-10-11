//
//  Vector2D.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/7/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

extension CGVector{
    
    
    init(_ vector2:Vector2){
        self.init(dx: CGFloat(vector2.x),dy: CGFloat(vector2.y))
       
    }
    //vector math has this functionality
//    func force()->Double{
//
//        Double((self.dx*self.dx) + (self.dy*self.dy))
//
//    }
}
