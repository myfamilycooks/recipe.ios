//
//  HttpErrorParser.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/24/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation


public struct HttpErrorParser{
    
    public static func parse(data:Data?) -> BistroFiftyTwoError?{
        
        if let data = data {
            do {
                let bistroError = try JSONDecoder().decode(BistroFiftyTwoError.self , from: data)
                return bistroError
            }
            catch(let ex){
                // we don't care what the exception/error is.
                return nil
            }
        }
        return nil
    }
}


public struct BistroFiftyTwoError: Decodable{
    
    var errorType:String?
    
    var description:String?
    
    var fieldName:String?
    
}
