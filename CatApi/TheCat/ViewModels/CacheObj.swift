//
//  CacheObj.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/26/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation

class CacheObj<T>: NSObject {
    fileprivate var items: [String:T] = [:]
    
    subscript(id: String) -> T? {
        get {
          return items[id]
        }
        set {
            self.items[id] = newValue
        }
    }
}
