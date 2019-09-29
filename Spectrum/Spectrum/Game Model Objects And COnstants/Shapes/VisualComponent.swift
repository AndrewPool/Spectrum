//
//  VisualComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class VisualComponent: GKComponent{
    
    let shapeNode : SpectrumShape
    
   
    init(shape: Shape, player:Player, size:Int){
        shapeNode = SpectrumShape(shape: shape, player: player, size: size)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
