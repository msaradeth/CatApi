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




//// MARK: - CatViewModelDelegate
//extension CatViewModel: CatViewModelDelegate {
//
////    func updateImage(sectionIndex: Int, index: Int, image: UIImage) {
////        guard sectionIndex != CatType.favorite.getIndex(), index < cats[sectionIndex].count else { return }
////
////        cats[sectionIndex][index].image = image
////        let imageCount = cats[sectionIndex].filter( { $0.image != nil } ).count
////        if imageCount == cats[sectionIndex].count {
////            subject.onNext(displayCats)
////        }
////    }
//

//
//    func toggleFavorite(index: Int) {
//        switch currCatType {
//        case .favorite:
//            let cat = displayCats[index]
//            toggleFavoriteCatTypeWithID(cat: cat)
//        default:
//            toggleCatTypeWithIndex(aCatTye: currCatType, srcIndex: index)
//        }
//        subject.onNext(displayCats)
//    }
//
//
//    // Toggle current cat type with index
//    private func toggleCatTypeWithIndex(aCatTye: CatType, srcIndex: Int) {
//        if cats[aCatTye.getIndex()][srcIndex].isMyFavorite {
//            cats[aCatTye.getIndex()][srcIndex].isMyFavorite = false
//        }else {
//            cats[aCatTye.getIndex()][srcIndex].isMyFavorite = true
//        }
//    }
//
//    // Toggle source cat type that has matching ID and set to NOT isMyFavorite
//    private func toggleFavoriteCatTypeWithID(cat: Cat) {
//        // Interate cats array except favorite catType
//        for segmentIndex in 0..<cats.count {
//            // Skip favorite section
//            let aCatTye = CatType.getType(segmentIndex: segmentIndex)
//            if aCatTye == CatType.favorite { continue }
//
//            // Search for aCatType that contains given ID, if found set to NOT isMyFavorite
//            for index in 0..<cats[segmentIndex].count {
//                if cat.id == cats[segmentIndex][index].id {
//                    cats[aCatTye.getIndex()][index].isMyFavorite = !cat.isMyFavorite
//                }
//            }
//        }
//    }
//
//}
