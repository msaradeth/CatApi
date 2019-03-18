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



final class HttpHelper: NSObject {

    class func request(_ url: URLConvertible, method: HTTPMethod, params: Parameters, success: @escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
        let headers = ["x-api-key":ApiParams.apiKey]        
        Alamofire.request(url, method: method, parameters: params, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
//    class func get(_ strURL: String, params: [String : AnyObject], success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
//        Alamofire.request(strURL).responseJSON { (response) -> Void in
//            print(response)
//            switch response.result {
//            case .success:
//                success(response)
//            case .failure(let error):
//                failure(error)
//            }
//        }
//    }
    
    //    class func post(_ strURL : String, params : [String : AnyObject]?, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void){
    //        let headers = ["x-api-key":ApiParams.apiKey]
    //        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
    //            switch response.result {
    //            case .success:
    //                success(response)
    //            case .failure(let error):
    //                failure(error)
    //            }
    //        }
    //    }
    
//    class func post(_ strURL : String, params : [String : AnyObject]?, success:@escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void){
//        let headers = ["x-api-key":ApiParams.apiKey]
//        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) -> Void in
//            switch response.result {
//            case .success:
//                success(response)
//            case .failure(let error):
//                failure(error)
//            }
//        }
//    }
}
    
    
    



    
//    deinit {
//        print("HttpHelp func deinit() debug")
//    }
//}
