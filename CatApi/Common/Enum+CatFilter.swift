//
//  Enum+CatFilter.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/17/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation



protocol GetValueProtocol {
    func getFilterValue() -> String
    func getIndex() -> Int
}



enum ApiParams {
    static let apiKey = "21a25674-3630-4395-8a64-9057ee4edd6d"
    static let baseURLPath = "https://api.thecatapi.com/v1/images/search?"      
    static let userId = "tldnpr"
    static var authenticationToken: String?
}


enum CatType: GetValueProtocol {
    case all
    case jpg
    case png
    case gif
    case favorite
    
    func getIndex() -> Int {
        switch self {
        case .all:
            return 0
        case .jpg:
            return 1
        case .png:
            return 2
        case .gif:
            return 3
        case .favorite:
            return 4
        }
    }
    
    func getFilterValue() -> String {
        switch self {
        case .all:
            return "all"
        case .jpg:
            return ".jpg"
        case .png:
            return ".png"
        case .gif:
            return ".gif"
        case .favorite:
            return "favorite"
        }
    }
    
    static func getType(segmentIndex: Int) -> CatType {
        switch segmentIndex {
        case 0:
            return CatType.all
        case 1:
            return CatType.jpg
        case 2:
            return CatType.png
        case 3:
            return CatType.gif
        case 4:
            return CatType.favorite
        default:
            return CatType.all
        }
    }
}

