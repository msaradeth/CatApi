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
    
    class func newInstance() -> CatApiService {
        return CatApiService()
    }
    
    public func loadData(catType: CatType) -> Single<[Cat]> {
        return Single<[Cat]>.create { [weak self] single in
            let baseUrl = ApiConstant.baseURLPath
            let params = self?.getParams(catType: catType)

            HttpHelper.request(baseUrl, method: .get, params: params, success: { (response) in
                guard let responseData = response.data else {
                    single(.error(APIError.parseJSONError))
                    return
                }
                var cats: [Cat] = []
                do {
                    let decoder = JSONDecoder()
                    cats = try decoder.decode(Array<Cat>.self, from: responseData)
                } catch let error {
                    print(error.localizedDescription)
                }
                single(.success(cats))
                
            }, failure: { (myError) in
                single(.error(myError))
            })
            return Disposables.create()
        }
    }
    
    
    
    private func getParams(catType: CatType) -> [String:String] {
        //Setup params
        var params: [String: String] = [:]
        params["limit"] = "10"
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
        return params
    }
        
        
    deinit {
        print("CatApiService func deinit() debug")
    }
    
}


// MARK: - Mock data for testing before API's ready
extension CatApiService {
    
        public func loadTestMockData(catType: CatType) -> Single<[Cat]> {
            return Single<[Cat]>.create { single in
                let cat = Cat(id: "1", url: "https://cdn2.thecatapi.com/images/4ni.jpg", isMyFavorite: false, image: nil)
                let cat2 = Cat(id: "2", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false, image: nil)
                let cat22 = Cat(id: "22", url: "https://cdn2.thecatapi.com/images/4ni.png", isMyFavorite: false, image: nil)
                let cat3 = Cat(id: "3", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false, image: nil)
                let cat33 = Cat(id: "33", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false, image: nil)
                let cat333 = Cat(id: "333", url: "https://cdn2.thecatapi.com/images/4ni.gif", isMyFavorite: false, image: nil)
    
                var cats: [Cat] = []
                switch catType {
                case .all:
                    cats.append(cat)
                    cats.append(cat2)
                    cats.append(cat22)
                    cats.append(cat3)
                    cats.append(cat33)
                    cats.append(cat333)
                case .jpg:
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
    

}
        
 
