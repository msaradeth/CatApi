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
    fileprivate var delegate: ToggleFavorite?
    fileprivate var index: Int!
    
    func configure(item: Cat, index: Int, toggleFavorite: ToggleFavorite) {
        self.index = index
        self.delegate = toggleFavorite
        favoriteImageView.image = item.isMyFavorite == true ? myFavoriteImage : notMyFavoriteImage
        addTapGestureRecognizer(view: favoriteContainerView)    // add TapGestureRecognizer
        
        //Update cat image
        guard let imageURL = URL(string: item.url),
            let imageData = try? Data(contentsOf: imageURL),
            let catImage =  UIImage(data: imageData)
        else { return }
        catImageView.image = catImage                        
    }
    
    @IBAction func tabFavorite(_ sender: UITapGestureRecognizer) {
        delegate?.toggleFavorite(index: index)
    }
    
    func addTapGestureRecognizer(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabFavorite(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}
