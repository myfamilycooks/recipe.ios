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
    
    func getToken(userName:String, password:String, completed:@escaping(_ succeeded:Bool, _ errorMessage:String?, _ token:TokenResponse?) ->()){
        
        let url = "\(self.baseUrl)/token"
        
        let postDictionary = self.createPostDictionary(userName: userName, password: password)
        
        Alamofire.request(url, method: .post, parameters: postDictionary, encoding: JSONEncoding.default)
            .responseJSON { (responseData) in
                switch responseData.result{
                case.success(let val):
                    do{
                        let token = try JSONDecoder().decode(TokenResponse.self, from: responseData.data!)
                        
                        if let token = token.token{
                            SecurityService.currentToken = token
                        }
                        
                        completed(true,nil,token)
                    } catch(let serializationError){
                        completed(false,"Serialization error: \(serializationError.localizedDescription)", nil)
                    }
                    
                case .failure(let error):
                    completed(false, error.localizedDescription, nil)
                }
        }
    }
    
    private func createPostDictionary(userName:String, password:String)->Parameters {
        
        var postData = [String:Any]()
        
        postData["userName"] = userName
        postData["password"] = password
        return postData
    }
    
}
