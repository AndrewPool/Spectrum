//
//  BuddyComponent.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/30/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//
import GameKit

class BuddyComponent: GKComponent{
    
    let shapeNode : SpectrumShape
    weak var buddyEntity : BuddyEntity!//must set up imediatly
  //  weak var gameComponent : GameComponent
    //-------------update and helpers----------------------
    
    //------------init and set up-----------------
      convenience init(shape: Shape, player:Player, size:Int, scene:SpectrumScene){
          
          let shape = SpectrumShape(shape: shape, player: player, size: size)
          
          self.init(shape, scene)
      }
      
      init(_ spectrumShape:SpectrumShape,_ scene:SpectrumScene){
          
          shapeNode = spectrumShape
          
          super.init()
          //this is gross but i mean what can you do
          
          shapeNode.setUpCollisionAsSpawner()
          
      }
      func setEntity(){
          let parent = entity as! BuddyEntity
          buddyEntity = parent
          
      }
      
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
