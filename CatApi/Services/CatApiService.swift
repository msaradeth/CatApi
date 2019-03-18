//
//  CatApiService.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift


class CatApiService: NSObject {
    let disposeBag = DisposeBag()
    
    public func loadData(catType: CatType) -> Single<[Cat]> {
        return Single<[Cat]>.create { single in
            let cat = Cat(breads: [], id: "1", url: "https://cdn2.thecatapi.com/images/4ni.jpg", isMyFavorite: false)
            let cat2 = Cat(breads: [], id: "2", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
            let cat22 = Cat(breads: [], id: "22", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
            let cat3 = Cat(breads: [], id: "3", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
            let cat33 = Cat(breads: [], id: "33", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
            let cat333 = Cat(breads: [], id: "333", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)

            var cats: [Cat] = []
            switch catType {
            case .all:
                cats.append(cat)
                cats.append(cat2)
                cats.append(cat22)
                cats.append(cat3)
                cats.append(cat33)
                cats.append(cat333)
            case .jpeg:
                cats.append(cat)
            case .png:
                cats.append(cat2)
                cats.append(cat22)
            case .gif:
                cats.append(cat3)
                cats.append(cat33)
                cats.append(cat333)
            default:
                break
            }
            single(.success(cats))
            
            
            return Disposables.create()
        }
    }
    
//    init() {
//        print("CatApiService func init() debug")
//    }
    
//    public func loadData() -> Observable<[Cat]> {
//        return Observable.create { (observer) -> Disposable in
//            let baseUrl = API.baseURLPath
//
//            var params: [String: String] = [:]
//            params["os"] = "iOS"
//
//            HttpHelper.request(urlString, method: .get, params: params, success: { (response) in
//                do {
//                    let faqs = try JSONDecoder().decode(Array<FaqStruct>.self, from: response.data!)
//                    let sortedFaqs = faqs.sorted { ( ((Int($0.Priority)!)*100) + (Int($0.id)!) ) <  ( ((Int($1.Priority)!)*100)  + (Int($1.id)!) )}
//                    FaqService.cacheFaq = sortedFaqs
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//                //pass data back
//                observer.onNext(FaqService.cacheFaq)
//                observer.onCompleted()
//
//            }, failure: { (error) in
//                print(error.localizedDescription)
//                observer.onError(error)
//            })
//        }
//        return Disposables.create()
//
//    }
    
    
    deinit {
        print("CatApiService func deinit() debug")
    }

}
