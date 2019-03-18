//
//  Cat.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

struct Category: Decodable {
    var id: String
    var name: String
}

struct CatDecode: Decodable {
    var breads: [String]?
    var id: String?
    var url: String?
    var categories: [Category]?
}

struct Cat: Decodable {
    var breads: [String]
    var id: String
    var url: String
    var isMyFavorite: Bool
}


