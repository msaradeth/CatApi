//
//  TheCatViewModel.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift


protocol ToggleFavorite {
    func toggleFavorite(index: Int)
}

class CatViewModel: ToggleFavorite {
    let disposeBag = DisposeBag()
    var subject: BehaviorSubject<[Cat]>
    var cats: [[Cat]]
    var currCatType: CatType
    var displayCats: [Cat] {
        switch currCatType {
        case .favorite:
            return cats[currCatType.getIndex()].filter({ $0.isMyFavorite == true } )
        default:
            return cats[currCatType.getIndex()]
        }
    }
    
    init() {
        currCatType = .all
        subject = BehaviorSubject<[Cat]>(value: [])
        
        //Init cats with empty array
        cats = []
        for _ in 0..<5 {
            cats.append([Cat]())
        }
    }
    
    func setCurrentCatType(catType: CatType) {
        currCatType = catType
        if cats[currCatType.getIndex()].count > 0 {
            subject.onNext(displayCats)
        }else {
            loadData()
        }
    }
    
    func toggleFavorite(index: Int) {
        if cats[currCatType.getIndex()][index].isMyFavorite {
            cats[currCatType.getIndex()][index].isMyFavorite = false
        }else {
            cats[currCatType.getIndex()][index].isMyFavorite = true
        }
    }
    
    func loadData() {
        let catApi = CatApiService()
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
