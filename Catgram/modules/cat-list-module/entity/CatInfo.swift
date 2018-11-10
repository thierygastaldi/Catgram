//
//  CatInfo.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import ObjectMapper

private let ID = "id"
private let URL = "url"
private let WIDTH = "width"
private let HEIGHT = "height"

class CatInfo: Mappable {
    
    var id: String?
    var url: String?
    var width: Float?
    var height: Float?
    var hasLike: Bool? = false
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map) {
        id <- map[ID]
        url <- map[URL]
        width <- map[WIDTH]
        height <- map[HEIGHT]
    }
}
