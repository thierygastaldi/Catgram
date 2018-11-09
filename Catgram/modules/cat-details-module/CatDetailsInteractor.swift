//
//  CatDetailsInteractor.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CatDetailsInteractor: CatDetailsInteractorInputProtocol {
    var presenter: CatDetailsInteractorOutputProtocol?
    private var sessionManager: SessionManager?
    
    func retrieveCatDetails(with catInfo: CatInfo) {
        
        // set default configurations
        let configuration = URLSessionConfiguration.default
        sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        // set default headers
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        
        // add custom headers
        headers["x-api-key"] = API_KEY
        headers["Content-Type"] = "application/json"
        
        let path = URL_CAT_INFO + catInfo.id!
        
        // request with the session manager
        sessionManager?.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            debugPrint(response)
            let objectResponse = response.result.value as! NSDictionary
        }
    }
}
