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

    class func request(_ url: URLConvertible, method: HTTPMethod, params: Parameters?, success: @escaping (DataResponse<Any>) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(url, method: method, parameters: params, headers: ApiConstant.headers).responseJSON { response in
            switch response.result {
            case .success:
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
