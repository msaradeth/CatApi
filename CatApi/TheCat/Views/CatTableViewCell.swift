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
    fileprivate var delegate: CatViewModelDelegate?
    fileprivate var cache: Cache!
    
    func configure(item: Cat, sectionIndex: Int, index: Int, delegate: CatViewModelDelegate) {
        self.item = item
        self.sectionIndex = sectionIndex
        self.index = index
        self.delegate = delegate
        
        //update favorite/NotFavorite image
        favoriteImageView.image = getFavoriteImage(id: item.id)
        addTapGestureRecognizer(view: favoriteContainerView)
        
        //Update cat image
        if let catImage = delegate.getCatImage(id: item.id) {
            catImageView.image = catImage
        }else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: item.url),
                    let imageData = try? Data(contentsOf: imageURL),
                    let catImage =  UIImage(data: imageData)
                    else { return }
                
                DispatchQueue.main.async {
                    self.delegate?.setCatImage(id: item.id, image: catImage)
                    self.catImageView.image = catImage
                }
            }
        }
        
    }
    
    @IBAction func tabFavorite(_ sender: UITapGestureRecognizer) {
        delegate?.toggleFavorite(id: item.id)
        favoriteImageView.image = getFavoriteImage(id: item.id)
    }
    
    func getFavoriteImage(id: String) -> UIImage? {
        guard let delegate = self.delegate else { return nil }        
        let isMyFavorite = delegate.isMyFavorite(id: id)
        return isMyFavorite ? myFavoriteImage : notMyFavoriteImage
    }
    

    func addTapGestureRecognizer(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabFavorite(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    deinit {
        print("CatTableViewCell deinit")
    }
}
