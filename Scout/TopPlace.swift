//
//  TopPlace.swift
//  Scout
//
//  Created by Akshay Pimprikar.
//  Copyright © 2016 Akshay Pimprikar. All rights reserved.
//

import UIKit
import Foundation

class TopPlace {
    let name: String
    let imageURL: String?
    let placeid: String?
    
    init(name: String?, imageURL: String?, placeid: String?) {
        self.name = name!
        self.imageURL = imageURL
        self.placeid = placeid
    }
}
