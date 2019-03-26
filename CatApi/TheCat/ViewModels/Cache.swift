//
//  Cache.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/19/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

enum Cache {
    static public let catImages: CacheObj<UIImage> = CacheObj<UIImage>()
    static public let isFavorite: CacheObj<Bool> = CacheObj<Bool>()
}

