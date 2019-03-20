//
//  Cat.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


struct Cat: Codable, Equatable, Hashable {
    var id: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case id
        case url
    }
}


