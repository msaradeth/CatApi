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
        
        
 
