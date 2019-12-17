//
//  SKEmitterHelper.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/21/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
//import VectorMath
import GameKit

class SKEmitterHelper{
    static func targetEmitter(with loc: CGPoint,focus: CGPoint)->SKEmitterNode{
        
        let te = SKEmitterNode(fileNamed: "TargetEmitter")!
        te.position = focus
        //te.setAngle(with: loc)
        te.emissionAngle = CGFloat(Vector2(loc).angle(with: Vector2(focus))) * CGFloat(Scalar.degreesPerRadian)
        print(CGFloat(Vector2(loc).angle(with: Vector2(focus))) * CGFloat(Scalar.degreesPerRadian))
        return te
    }
    
    
}

extension SKEmitterNode{
    
    
    public func focusFire(color:UIColor)->SKEmitterNode{
        
        return SKEmitterNode(fileNamed: "FocusFire.sks")!
    }
    
    func setAngle(with loc: CGPoint){
        let selfLocInScene = CGPoint(x:parent!.position.x + self.position.x, y: parent!.position.y + self.position.y)
        print("\(loc)  \(selfLocInScene)")
        let emissionAngle = CGFloat(Vector2(selfLocInScene).angle(with: Vector2(self.position))) //* CGFloat(Scalar.degreesPerRadian)
        print(emissionAngle)
        self.emissionAngle = emissionAngle
    }
//
//
}
