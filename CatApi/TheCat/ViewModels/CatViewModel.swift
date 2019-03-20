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
                loadData()
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
    var dataSource: DataSource
    var cache: Cache {
        return dataSource.cache
    }
    
    init(catType: CatType, dataSource: DataSource) {
        currCatType = catType
        self.dataSource = dataSource
        subject = BehaviorSubject<[Cat]>(value: [])
        cats = []
        for _ in 0..<5 {
            cats.append([Cat]())    //Init with empty arrays
        }
    }
    
    
    func loadData() {
        guard displayCats.count == 0, currCatType != .favorite else {
            subject.onNext(displayCats)
            return
        }
        let catApi = CatApiService.newInstance()
        catApi.loadData(catType: currCatType)
            .subscribe { [weak self] event in
                guard let this = self else { return }
                switch event {
                case .success(let cats):
                    this.cats[this.currCatType.getIndex()] = cats
                    this.subject.onNext(this.displayCats)
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
}




// MARK: - Helper methods to get/set cat images and favorite cat
extension CatViewModel: CatViewModelDelegate {

    func toggleFavorite(id: String) {
        let toggleMyFavoriteCat = !(cache.isMyFavorite(id: id))
        cache.setMyFavorite(id: id, isFavorite: toggleMyFavoriteCat)
    }
    func isMyFavorite(id: String) -> Bool {
        return cache.isMyFavorite(id: id)
    }
    
    func getCatImage(id: String) -> UIImage? {
        return cache.getCatImage(id: id)
    }
    func setCatImage(id: String, image: UIImage) {
        cache.setCatImage(id: id, image: image)
    }
}

