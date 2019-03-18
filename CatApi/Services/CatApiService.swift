//
//  CatApiService.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON


class CatApiService: NSObject {
    
    class func newInstance() -> CatApiService {
        return CatApiService()
    }
    
    public func loadData(catType: CatType) -> Single<[Cat]> {
        return Single<[Cat]>.create { single in
            let baseUrl = ApiParams.baseURLPath
            
            //Set params
            var params: [String: String] = [:]
            params["limit"] = "50"
            switch catType {
            case .gif:
                fallthrough
            case .jpg:
                fallthrough
            case .png:
                params["mime_types"] = catType.getFilterValue()
            default:
                break
            }
            HttpHelper.request(baseUrl, method: .get, params: params, success: { (response) in
                print(response)
                var cats: [Cat] = []
                let resJson = JSON(response.result.value!)
                print(resJson)
                
//                guard let jsonArr = response.result.value as? [String:Any] else {
//                    single(.error(APIError.parseJSONError))
//                    return
//                }
                for object in resJson {
                    let id = object.1["id"]
                    let urlString = object.1["url"]
                    if urlString.count > 3 {
                        let fileExt = urlString.suffix(3)
                        print(fileExt)
//                        let catType = CatType.getTypeWithFileExt(fileExt: fileExt)
                        
                    }
                }
                
                

//                do {
//                    catDecode = try JSONDecoder().decode(Array<CatDecode>.self, from: response.data!)
//                } catch let error {
//                    print(error.localizedDescription)
//                }
                single(.success(cats))
                
            }, failure: { (myError) in
                single(.error(myError))
            })
            
            return Disposables.create()
        }
        

//            HttpHelper.request(baseUrl, method: .get, params: params, success: { (response) in
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


    }
    
    
    
    
    // MARK: - Mock data for testing
//    public func loadDataMockData(catType: CatType) -> Single<[Cat]> {
//        return Single<[Cat]>.create { single in
//            let cat = Cat(breads: [], id: "1", url: "https://cdn2.thecatapi.com/images/4ni.jpg", isMyFavorite: false)
//            let cat2 = Cat(breads: [], id: "2", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
//            let cat22 = Cat(breads: [], id: "22", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false)
//            let cat3 = Cat(breads: [], id: "3", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
//            let cat33 = Cat(breads: [], id: "33", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
//            let cat333 = Cat(breads: [], id: "333", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false)
//
//            var cats: [Cat] = []
//            switch catType {
//            case .all:
//                cats.append(cat)
//                cats.append(cat2)
//                cats.append(cat22)
//                cats.append(cat3)
//                cats.append(cat33)
//                cats.append(cat333)
//            case .jpg:
//                cats.append(cat)
//            case .png:
//                cats.append(cat2)
//                cats.append(cat22)
//            case .gif:
//                cats.append(cat3)
//                cats.append(cat33)
//                cats.append(cat333)
//            default:
//                break
//            }
//            single(.success(cats))
//
//
//            return Disposables.create()
//        }
//    }
//
    
    deinit {
        print("CatApiService func deinit() debug")
    }

}
