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
            self.presenter?.onError(with: "No internet connection.")
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
            debugPrint(response)
            let arrayResponse = response.result.value as! NSArray
            let arrayObject = Mapper<CatInfo>().mapArray(JSONArray: arrayResponse as! [[String : Any]])
            debugPrint(arrayObject)
            self.presenter?.didRetrieveCatListSuccess(catList: arrayObject)
        }
    }
}
