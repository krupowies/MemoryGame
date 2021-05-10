//
//  Array+Identifable.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 10/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import Foundation

extension Array where Element : Identifiable {
    
    func firstIndex(matching : Element) -> Int? {
        for index in 0 ..< self.count {
            if self[index].id == matching.id{
                return index
            }
        }
        return nil
    }
}
