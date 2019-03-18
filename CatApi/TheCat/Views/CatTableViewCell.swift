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
    fileprivate var delegate: CatViewModelDelegate?
    fileprivate var sectionIndex: Int!
    fileprivate var index: Int!
    
    func configure(item: Cat, sectionIndex: Int, index: Int, catViewModelDelegate: CatViewModelDelegate) {
        self.sectionIndex = sectionIndex
        self.index = index
        self.delegate = catViewModelDelegate
        favoriteImageView.image = item.isMyFavorite == true ? myFavoriteImage : notMyFavoriteImage
        addTapGestureRecognizer(view: favoriteContainerView)    // add TapGestureRecognizer
        
        //Update cat image
        if let catImage = item.image {
            catImageView.image = catImage
        }else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: item.url),
                    let imageData = try? Data(contentsOf: imageURL),
                    let catImage =  UIImage(data: imageData)
                    else { return }
                
                DispatchQueue.main.async {
                    self.catImageView.image = catImage
                    self.delegate?.updateImage(sectionIndex: sectionIndex, index: index, image: catImage)
                }

            }
        }
        
    }
    
    @IBAction func tabFavorite(_ sender: UITapGestureRecognizer) {
        delegate?.toggleFavorite(index: index)
    }
    
    func addTapGestureRecognizer(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabFavorite(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}
