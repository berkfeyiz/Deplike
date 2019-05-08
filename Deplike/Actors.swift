//
//  Actors.swift
//  Deplike
//
//  Created by Feyiz on 02/05/19.
//  Copyright © 2019 Feyiz. All rights reserved.
//

import Foundation

struct Actor {
    let name:String
    let photo:String
    let popularity:Int
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String,Any)
    }
    
    init(json:[String:Any]) throws
    {
        guard let name = json["name"] as? String else {throw SerializationError.missing("name is missing")}
        
        guard let photo = json["profile_path"] as? String else {throw SerializationError.missing("photo is missing")}
        
        guard let popularity = json["popularity"] as? Int else {throw SerializationError.missing("popularity is missing")}
        
        self.name = name
        self.photo = photo
        self.popularity = popularity
    }
    
   
    
    
    
    static func popularities (withURL path:String, completion: @escaping ([Actor])->())
    {
        let url = path
        let request = URLRequest(url: URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: request) {(data:Data? , responce:URLResponse? , error:Error?) in
        
        var actorsarray:[Actor] = []
        
            if let data = data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        if let x = json["results"] as? [[String:Any]]
                            {
                                for y in x {
                                    if let actorObject = try? Actor(json : y)
                                    { actorsarray.append(actorObject)      }
                                }
                            }
                    }
                }catch{
                        print(error.localizedDescription)
                }
                completion(actorsarray)
            }
            
        }
        task.resume()
    }
    
    static func search(withName name:String, completion: @escaping ([Actor])->())
    {
        let searchpath = "https://api.themoviedb.org/3/search/person?api_key=37419e0b5068a826126bd5bd72b6d026&language=en-US&query=\(name)&include_adult=false"
       
        let url = searchpath
        let request = URLRequest(url: URL(string:url)!)
        
        let task = URLSession.shared.dataTask(with: request) {(data:Data? , responce:URLResponse? , error:Error?) in
        
            var actorsarray:[Actor] = []
           
                if let data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                            if let x = json["results"] as? [[String:Any]]
                            {
                                for y in x {
                                    if let actorObject = try? Actor(json : y)
                                    { actorsarray.append(actorObject) }
                                }
                            }
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                    completion(actorsarray)
                }
            
            
        }
        task.resume()
    }
    
}


