//
//  Connectivity.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 09/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
