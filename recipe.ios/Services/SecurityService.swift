//
//  SecurityService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import Alamofire
public class SecurityService{
    
    static func getHeaders() -> HTTPHeaders{
        var headers = HTTPHeaders()
        headers["Authorization"] = "Bearer \(currentToken)"
        
        return headers
    }
    
    static var currentToken:String = ""
    
}
