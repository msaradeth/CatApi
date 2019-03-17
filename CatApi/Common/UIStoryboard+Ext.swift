//
//  UIStoryboard+Ext.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


extension UIStoryboard {
    
    public static func createWith(storyBoard: String, withIdentifier: String) -> UIViewController {
        let vc = UIStoryboard.init(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        return vc
    }
}


