//
//  DataSource.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/20/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation

class DataSource: NSObject {
    var cache: Cache {
        return Cache.shared
    }
    
    
    // MARK: set and get favorite cats
    public func isMyFavorite(id: String) -> Bool {
//        return (isFavorite[id] ?? false)
        return true
    }
    public func setMyFavorite(id: String, isFavorite: Bool) {
//        self.isFavorite[id] = isFavorite
    }
     
}
