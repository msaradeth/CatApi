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

protocol CacheInterface {
    func isMyFavorite(id: String) -> Bool
    func setMyFavorite(id: String)
}

class Cache: NSObject {
    static let shared = Cache()
    
    fileprivate var images: [String:UIImage]
    fileprivate var isFavorite: [String:Bool]
    
    private override init() {
        images = [:]
        isFavorite = [:]
    }

    func isMyFavorite(id: String) -> Bool {
        return (isFavorite[id] ?? false)
    }
    
    func setMyFavorite(id: String) {
        self.isFavorite[id] = true
    }
    func setNotMyFavorite(id: String) {
        self.isFavorite[id] = false
    }
    
    
    func getImage(id: String) -> UIImage? {
        return images[id] ?? nil
    }
    func setImage(id: String, image: UIImage) {
        images[id] = image
    }

}
