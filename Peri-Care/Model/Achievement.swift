//
//  File.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import Foundation

class Achievement {
    var name: String
    var isCompleted: Bool
    var description: String
    var image: String
    init(name: String, isCompleted: Bool, description: String, image: String) {
        self.name = name
        self.isCompleted = isCompleted
        self.description = description
        self.image = image
    }
}
