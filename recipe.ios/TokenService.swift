//
//  TokenService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/11/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import Alamofire

public class TokenService{
    
    var baseUrl:String
    
    init(){
        self.baseUrl = Configuration.webUrl
    }
    
    func getToken(userName:String, password:String, completed:@escaping(_ succeeded:Bool, _ errorMessage:String?, _ account:UserAccountResponse?) ->()){
        
    }
}
