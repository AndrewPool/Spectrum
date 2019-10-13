//
//  Extensions.swift
//  Spectrum
//
//  Created by Andrew Pool on 10/10/19.
//  Copyright © 2019 TokenResearch. All rights reserved.
//

import Foundation
import GameKit

extension GKComponent{
    
    func entityAs<T>()->T?{
        if let e = entity as? T{
            return e as T
        }
        return nil
    }
    func spawnerEntity()->SpawnerEntity{
         entity as! SpawnerEntity
    }
    func buddyEntity()->BuddyEntity{
        entity as! BuddyEntity
    }
}

