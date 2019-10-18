//
//  GameCollisionProtocol.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/11/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation

protocol GameCollisionProtocol {
    var player : PlayerComponent { get set }
    func attack(player:PlayerComponent)->Int
    func hit(player:PlayerComponent, attack:Int)
}
