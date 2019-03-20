//
//  Cache.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/19/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class Cache: NSObject {
    static let shared = Cache()
    
    var images: [String:UIImage]
    var isFavorite: [String:Bool]
    
    private override init() {
        images = [:]
        isFavorite = [:]
    }
    

}
