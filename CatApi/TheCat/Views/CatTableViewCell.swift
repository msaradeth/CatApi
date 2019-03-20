//
//  CatTableViewCell.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/17/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit
import RxSwift

class CatTableViewCell: UITableViewCell {
    static let identifier = "Cell"
    let myFavoriteImage = UIImage(named: "MyFavorite")
    let notMyFavoriteImage = UIImage(named: "NotMyFavorite")
    
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var favoriteContainerView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    fileprivate var sectionIndex: Int!
    fileprivate var index: Int!
    fileprivate var item: Cat!
    fileprivate var cache: Cache!
    
    func configure(item: Cat, sectionIndex: Int, index: Int, cache: Cache) {
        self.item = item
        self.sectionIndex = sectionIndex
        self.index = index
        self.cache = cache
        
        //update favorite/NotFavorite image
        let isFavorite = cache.isFavorite[item.id] ?? false
        favoriteImageView.image = isFavorite ? myFavoriteImage : notMyFavoriteImage
        addTapGestureRecognizer(view: favoriteContainerView)
        
        //Update cat image
        if let catImage = cache.images[item.id] {
            catImageView.image = catImage
        }else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: item.url),
                    let imageData = try? Data(contentsOf: imageURL),
                    let catImage =  UIImage(data: imageData)
                    else { return }
                
                DispatchQueue.main.async {
                    self.catImageView.image = catImage
                    Cache.shared.images[item.id] = catImage
                }
            }
        }
        
    }
    
    @IBAction func tabFavorite(_ sender: UITapGestureRecognizer) {
        toggleFavorite(id: item.id)
    }
    
    func toggleFavorite(id: String) {
        let isFavorite = Cache.shared.isFavorite[id] ?? false
        let image = isFavorite ? notMyFavoriteImage : myFavoriteImage
        favoriteImageView.image = image
        
        cache.isFavorite[id] = !isFavorite
    }
    
    func addTapGestureRecognizer(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabFavorite(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    deinit {
        print("CatTableViewCell deinit")
    }
}
