//
//  Array+Only.swift
//  MemoryGame
//
//  Created by Wojtek Krupowies on 10/05/2021.
//  Copyright © 2021 Wojtek Krupowies. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
