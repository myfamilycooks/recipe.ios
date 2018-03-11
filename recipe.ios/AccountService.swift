//
//  AccountService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 3/10/18.
//  Copyright © 2018 My Family Cooks. All rights reserved.
//

import Foundation
import Alamofire 

public class AccountService{
    
    var baseUrl:String
    
    init(){
        self.baseUrl = Configuration.webUrl
    }
    
    func createAccount(login:String, fullName:String, email:String, password:String,
                       completed:@escaping(_ succeeded:Bool, _ errorMessage:String?, _ account:UserAccountResponse?) ->()){
        
        let url = "\(self.baseUrl)/api/account/create/new/"
        let postDictionary = self.createPostDictionary(login: login, fullName: fullName, email: email, password: password)
        
        Alamofire.request(url, method: .post, parameters: postDictionary, encoding: JSONEncoding.default)
            .responseJSON { (responseData) in
                switch responseData.result{
                case.success(let val):
                    do{
                        let userAccountResponse = try JSONDecoder().decode(UserAccountResponse.self, from: responseData.data!);
                        completed(true, nil, userAccountResponse)
                    } catch(let serializationError){
                        completed(false,"Serialization error: \(serializationError.localizedDescription)", nil)
                    }
                    
                case.failure(let error):
                    completed(false, error.localizedDescription, nil)
                }
        }
    }
    
    
    private func createPostDictionary(login:String, fullName:String, email:String, password:String)->Parameters {
        
        let postData: Parameters = [
        
        "login" : login,
        "email" : email
        //result["fullName"] = fullName
        //result["password"] = password
        //result["invitation"] = "0e1c3bfd-ca76-4d99-8965-44dad10f1f60"
        ]
        
        return postData
    }
}
