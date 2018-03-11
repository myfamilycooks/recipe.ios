//
//  UserAccountResponse.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/10/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation

public struct UserAccountResponse: Decodable{
    
    var userLogin:String?
    
    var accountPassword:String?
    
    var salt:String?
    
    var passwordFormat: String?
    
    var fullName:String?
    
    var email:String?
    
    var IsLocked: Bool?
    
    var id:String?
    
    var createdDate: Date?
    
}
