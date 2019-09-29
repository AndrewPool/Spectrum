//
//  ControlComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/28/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import GameKit

class ControlComponent: GKComponent,ControlDelegate{
    var selected: Bool = false
    
    weak var spawnerEntity: SpawnerEntity!
    
    init(controler:SpawnerEntity){
        spawnerEntity = controler
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func touchesBegan(touches: Set<UITouch>) {
        print("Component TD")
    }
    
    func touchesMoved(touches: Set<UITouch>) {
        print("Component TM")
    }
    
    func touchesEnded(touches: Set<UITouch>) {
        print("Component TE")
    }
    
    func touchesCancelled(touches: Set<UITouch>) {
        print("Component CANCELLED")
    }
    
    
    
}
