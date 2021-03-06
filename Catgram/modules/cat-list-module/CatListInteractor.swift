//
//  CatListInteractor.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CatListInteractor: CatListInteractorInputProtocol {
    var presenter: CatListInteractorOutputProtocol?
    private var sessionManager: SessionManager?
    
    func retrieveCatList() {
        
        // Check connection
        if !Connectivity.isConnectedToInternet {
            self.presenter?.onError(with: "The Internet connection appears to be offline.")
            return
        }
        
        // set default configurations
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        // set default headers
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        
        // add custom headers
        headers["x-api-key"] = API_KEY
        headers["Content-Type"] = "application/json"
        
        // request with the session manager
        sessionManager?.request(URL_CAT_LIST, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            guard case let .failure(error) = response.result else {
                debugPrint(response)
                if response.result.value is NSArray {
                    let arrayResponse = response.result.value as! NSArray
                    if arrayResponse is [[String : Any]] {
                        let arrayObject = Mapper<CatInfo>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
                        debugPrint(arrayObject)
                        self.presenter?.didRetrieveCatListSuccess(catList: arrayObject)
                    }
                    else {
                        self.presenter?.onError(with: "Unexpected Error")
                    }
                }
                else {
                    self.presenter?.onError(with: "Unexpected Error")
                }
                return
            }
            self.presenter?.onError(with: "\(error.localizedDescription)")
        }
    }
    
}
