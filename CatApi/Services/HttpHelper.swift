//
//  HttpHelper.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift



enum API {
    static let apiKey = "21a25674-3630-4395-8a64-9057ee4edd6d"
    static let baseURLPath = "https://api.thecatapi.com/v1/images/search?"
    static let userId = "tldnpr"
    static var authenticationToken: String?
    static let headers = [API.apiKey]
}


class HttpHelper: NSObject {

    
    class func get(_ strURL: String, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (response) -> Void in
            print(response)
            switch response.result {
            case .success:
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    class func post(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
            switch response.result {
            case .success:
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }    
}
    
    
    
    
//    func request(_ url: URLConvertible, method: HTTPMethod, params: Parameters?, success: @escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
//
//        Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { response in
//            switch response.result {
//            case .success:
//                //                let resJSON = JSON(response.result.value!)
//                //                print(resJSON)
//                success(response)
//
//            case .failure(let error):
////                ProgDialog.shared.showAlert(title: "API Error", subtitle: error.localizedDescription, buttonTitle: "OK")
//                failure(error)
//            }
//        }
//
////        Alamofire.request(url, method: method, parameters: params, encoding: .utfs, headers: headers) {
////
////        }
//    }
    
    
//    deinit {
//        print("HttpHelp func deinit() debug")
//    }
//}
