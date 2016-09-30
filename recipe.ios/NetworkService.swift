//
//  NetworkService.swift
//  recipe.ios
//
//  Created by Shaun Sargent on 9/29/16.
//  Copyright © 2016 My Family Cooks. All rights reserved.
//

import Foundation

public class NetworkService{
    
    func performNetworkCall(url:String, httpMethod:String, postParameters:[String:AnyObject]?, callComplete:@escaping (_ succeeded:Bool, _ message:String, _ jsonObject:Data?) ->()){
        
        // create a request and session from the given URL, also set the HttpVerb
        let request = NSMutableURLRequest(url: URL(string:url)!);
        let session = URLSession.shared;
        request.httpMethod = httpMethod;
        
        // add headers.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        request.addValue("application/json", forHTTPHeaderField: "Accept");
        
        // if there are post parameters
        if(postParameters != nil){
            
            do{
                request.httpBody = try JSONSerialization.data(withJSONObject: postParameters!, options: []);
            }catch{
                // if we couldn't serialalize the posting parameters.
                callComplete(false,  "unable to serialize post parameters: \(error)", nil);
            }
        }
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            // see if we got an error
            if(error != nil){
                
                // everything else just return a failure.
                callComplete(false, error!.localizedDescription, nil);
                
            }
            
            // otherwise the network call was successfully made, although we could get another error from the server.
            if let httpResponse = response as? HTTPURLResponse{
                
                switch httpResponse.statusCode{
                case 200:
                    
                    // we got the object, so return it to the caller.
                    callComplete(true, "success", data);
                default:
                    do{
                        
                        // try to get json from the object
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? NSDictionary;
                        
                        // this handles the case that the app threw a "BadRequest" response.
                        if let message = json?["Message"] as? String{
                            
                            //  see if we can get a more specific error message from the server.
                            if let exceptionMessage = json?["ExceptionMessage"] as? String{
                                
                                callComplete(false, "ServerException: \(exceptionMessage)", nil);
                            } else{
                                
                                // send back the message.
                                callComplete(false, message,nil);
                            }
                        }
                    } catch {
                        callComplete(false, "ERROR: Unable to serialize Error message from server: \(error)", nil);
                        
                    }
                    
                }
            } else{
                // if we weren't able to cast successfully, still return back that this network call failed.
                callComplete(false,  "Unknown error, unable to cast to NSHTTPURLResponse", nil);
            }
            
        }
        task.resume();
        
    }
    
}
