//
//  DataSource.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/20/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RealmSwift


class DataSource: NSObject {
    var cache: Cache {
        return Cache.shared
    }
         
}
