//
//  Item.swift
//  PhysicalBalls
//
//  Created by Wilbur Wong on 2024/3/20.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
