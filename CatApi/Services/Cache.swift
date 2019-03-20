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
    
    fileprivate var catImages: [String:UIImage]
    fileprivate var isFavorite: [String:Bool]
    
    private override init() {
        catImages = [:]
        isFavorite = [:]
    }

    
    // MARK: set and get favorite cats
    func isMyFavorite(id: String) -> Bool {
        return (isFavorite[id] ?? false)
    }
    func setMyFavorite(id: String, isFavorite: Bool) {
        self.isFavorite[id] = isFavorite
    }

    
    // MARK: set and get cat images
    func getCatImage(id: String) -> UIImage? {
        return catImages[id] ?? nil
    }
    func setCatImage(id: String, image: UIImage) {
        catImages[id] = image
    }

}
