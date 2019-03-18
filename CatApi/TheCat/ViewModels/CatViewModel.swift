//
//  TheCatViewModel.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift
//import RealmSwift


protocol ToggleFavorite {
    func toggleFavorite(index: Int)
}

class CatViewModel: ToggleFavorite {
    fileprivate let disposeBag = DisposeBag()
    var cats: [[Cat]]
    var subject: BehaviorSubject<[Cat]>
    var currCatType: CatType {
        didSet {
            if cats[currCatType.getIndex()].count > 0 {
                subject.onNext(displayCats)
            }else {
                loadData(catApi: CatApiService.newInstance())
            }
        }
    }
    var displayCats: [Cat] {
        switch currCatType {
        case .favorite:
            let myFavoriteCats = Array(cats.flatMap({ $0 }).filter({ $0.isMyFavorite == true } ))
            //Remove possible duplicate
            var catDict: [String:Cat] = [:]
            for cat in myFavoriteCats {
                catDict[cat.id] = cat
            }
            return Array(catDict.values)
            
        default:
            return cats[currCatType.getIndex()]
        }
    }
    
    init(catType: CatType) {
        currCatType = catType
        subject = BehaviorSubject<[Cat]>(value: [])
        cats = []
        for _ in 0..<5 {
            cats.append([Cat]())    //Init with empty arrays
        }
    }
    
    
    func loadData(catApi: CatApiService) {
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




// MARK: - Toggle isMyFavorite
extension CatViewModel {
    
    func toggleFavorite(index: Int) {
        switch currCatType {
        case .favorite:
            let cat = displayCats[index]
            toggleFavoriteCatTypeWithID(cat: cat)
        default:
            toggleCatTypeWithIndex(aCatTye: currCatType, srcIndex: index)
        }
        subject.onNext(displayCats)
    }
    
    
    // Toggle current cat type with index
    private func toggleCatTypeWithIndex(aCatTye: CatType, srcIndex: Int) {
        if cats[aCatTye.getIndex()][srcIndex].isMyFavorite {
            cats[aCatTye.getIndex()][srcIndex].isMyFavorite = false
        }else {
            cats[aCatTye.getIndex()][srcIndex].isMyFavorite = true
        }
    }
    
    // Toggle source cat type that has matching ID and set to NOT isMyFavorite
    private func toggleFavoriteCatTypeWithID(cat: Cat) {
        // Interate cats array except favorite catType
        for segmentIndex in 0..<cats.count {
            // Skip favorite section
            let aCatTye = CatType.getType(segmentIndex: segmentIndex)
            if aCatTye == CatType.favorite { continue }
            
            // Search for aCatType that contains given ID, if found set to NOT isMyFavorite
            for index in 0..<cats[segmentIndex].count {
                if cat.id == cats[segmentIndex][index].id {
                    cats[aCatTye.getIndex()][index].isMyFavorite = !cat.isMyFavorite
                }
            }
        }
    }
    
}
