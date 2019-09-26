//
//  Information.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import Foundation

class Information {
    var title: String
    var isCompleted: Bool
    var contentTitles: [String]
    var contentTexts: [String]
    var contentImages: [String]
    init(title: String, isCompleted: Bool, contentTitles: [String], contentTexts: [String], contentImages: [String]) {
        self.title = title
        self.isCompleted = isCompleted
        self.contentTitles = contentTitles
        self.contentTexts = contentTexts
        self.contentImages = contentImages
    }
}
