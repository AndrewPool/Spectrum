//
//  ControlDelagate.swift
//  Spectrum
//
//  Created by Andrew Pool on 9/23/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

//this is the delegate for what it means to do when you drag your finger around on the screen and shit
protocol ControlDelegate {
    var selected : Bool { get set }
    
    func touchesBegan(touches: Set<UITouch>)
    
    func touchesMoved(touches: Set<UITouch>)
    
    func touchesEnded(touches: Set<UITouch>)
    
    func touchesCancelled(touches: Set<UITouch>)

}
