//
//  Cat.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


struct Cat: Codable {
    var id: String
    var url: String
    var isMyFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
    }
}


