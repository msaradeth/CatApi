//
//  TheCatViewModel.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift


protocol CatViewModelDelegate {
    func toggleFavorite(id: String)
    func isMyFavorite(id: String) -> Bool
    func getCatImage(id: String) -> UIImage?
    func setCatImage(id: String, image: UIImage)
}

class CatViewModel {
    fileprivate let disposeBag = DisposeBag()
    var cats: [[Cat]]
    var subject: BehaviorSubject<[Cat]>
    var currCatType: CatType {
        didSet {
            if cats[currCatType.getIndex()].count > 0 {
                subject.onNext(displayCats)
            }else {
                loadData(catType: currCatType)
            }
        }
    }
    var displayCats: [Cat] {
        switch currCatType {
        case .favorite:
            // find favorite cats and remove duplicates with Set
            let myFavoriteCats = Array(Set(cats.flatMap({ $0 }).filter({ isMyFavorite(id: $0.id) } )))
            return myFavoriteCats
            
        default:
            return cats[currCatType.getIndex()]
        }
    }
    var isLoading: [Bool] = Array(repeating: false, count: 4)

    
    init(catType: CatType) {
        currCatType = catType
        subject = BehaviorSubject<[Cat]>(value: [])
        cats = Array(repeating: [Cat](), count: 5)
    }
    
    
    func loadData(catType: CatType = CatType.all) {
        guard displayCats.count == 0, catType != .favorite, !isLoading[catType.getIndex()] else {
            subject.onNext(displayCats)
            return
        }
        let catApi = CatApiService.newInstance()
        isLoading[catType.getIndex()] = true
        catApi.loadData(catType: catType)
            .subscribe { [weak self] event in
                guard let this = self else { return }
                switch event {
                case .success(let cats):
                    this.cats[catType.getIndex()] = cats
                    this.subject.onNext(this.displayCats)
                    this.isLoading[catType.getIndex()] = false
                case .error(let error):
                    print("Error: ", error)
                    this.isLoading[catType.getIndex()] = false
                }
            }
            .disposed(by: disposeBag)
    }
}




// MARK: - Helper methods to get/set cat images and favorite cat
extension CatViewModel: CatViewModelDelegate {

    func toggleFavorite(id: String) {
        Cache.isFavorite[id] = !isMyFavorite(id: id)
    }
    func isMyFavorite(id: String) -> Bool {
        return Cache.isFavorite[id] ?? false
    }
    
    func getCatImage(id: String) -> UIImage? {
        return Cache.catImages[id]
    }
    func setCatImage(id: String, image: UIImage) {
        Cache.catImages[id] = image
    }
}

