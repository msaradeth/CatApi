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
    @IBOutlet weak var favoriteImageView: UIImageView!
    var delegate: ToggleFavorite?
    var index: Int!
    
    func configure(item: Cat, index: Int, toggleFavorite: ToggleFavorite) {
        print(item.isMyFavorite)
        self.index = index
        self.delegate = toggleFavorite
        
        catImageView.image = item.isMyFavorite == true ? myFavoriteImage : notMyFavoriteImage
        favoriteImageView.image = item.isMyFavorite == true ? myFavoriteImage : notMyFavoriteImage
    }
 
    
    @IBAction func tabFavorite(_ sender: UITapGestureRecognizer) {
        delegate?.toggleFavorite(index: index)
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}
