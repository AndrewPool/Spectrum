//
//  Levels.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/17/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

struct Level{
    //lawlson
    static let locations = [
        //1
        [CGPoint(x: 100, y: 100),CGPoint(x: -100, y: 100),CGPoint(x: 100, y: -100),CGPoint(x: -100, y: -100)],
        //2
        [
            CGPoint(x: 200, y: 200),
            CGPoint(x: -200, y: 200),
            CGPoint(x: -300, y: 0),
                       CGPoint(x: 300, y: 0),
            CGPoint(x: 200, y: -200),
            CGPoint(x: -200, y: -200)
        ]
        //3
       // ,[CGPoint(x: 300, y: 300),CGPoint(x: -200, y: 300),CGPoint(x: 100, y: 150),CGPoint.zero,CGPoint(x: -100, y: -150),CGPoint(x: 200, y: -300),CGPoint(x: -300, y: -300)]
        //4
        ,[
             CGPoint(x: 300, y: 300)
            ,CGPoint(x: 200, y: -300)
            ,CGPoint(x: 100, y: 150)
            ,CGPoint(x: 50, y: -300)
            ,CGPoint.zero
            ,CGPoint(x: -50, y: 300)
            ,CGPoint(x: -100, y: -150)
            ,CGPoint(x: -200, y: 300)
            ,CGPoint(x: -300, y: -300)
        ]
        //5
        ,[
            CGPoint(x: 200, y: -300)
            ,CGPoint(x: 130, y: 150)
            ,CGPoint(x: 10, y: -300)
            ,CGPoint(x: -10, y: 300)
            ,CGPoint(x: -130, y: -150)
            ,CGPoint(x: -200, y: 300)
        ]
        //6
        ,[
            
            CGPoint(x: 200, y: -200)
            ,CGPoint(x: -400, y: -320)
            ,CGPoint(x: 250, y: 80)
            ,CGPoint(x: 10, y: -180)
            ,CGPoint(x: -10, y: 180)
            ,CGPoint(x: -250, y: -80)
            ,CGPoint(x: 400, y: 320)
            ,CGPoint(x: -200, y: 200)
            
        ]
        
    ]
    
    //first node can't be neutral! or breaks win check
    static let flavors = [
        //1
        [1,0,2,0]
        //2
        ,[1,0,0,0,0,2]
        //3
       // ,[1,0,0,0,0,0,2]
        //4
        ,[1,0,0,0,0,0,0,0,2]
        //5
        ,[1,0,0,0,0,2]
        //6
         ,[1,0,0,0,0,0,0,2]
    ]
   // static let mirrored
}
