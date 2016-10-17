//
//  JSONHelper.swift
//  SQLiteCRUD
//
//  Created by Thomas Woerdeman on 17/10/2016.
//  Copyright © 2016 Diederich Kroeske. All rights reserved.
//

import Foundation
import Alamofire

class JSONHelper {
    
    static let sharedInstance = JSONHelper()
    
    //API URL
    let url = "https://randomuser.me/api"
    
    //Method for fetching five contacts from the API
    func fetchContacts() {
        
        let person : Person? = Person()
        
        let databaseHelperInstance = DataBaseHelper.sharedInstance
        
        let parameters = ["results" : "5"]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            
            if let json = response.result.value as? Dictionary<String, Any> {
                for field in json["results"] as? [AnyObject] ?? []{
                    
                    //Full name
                    if let fullName = field["name"] as? [String : AnyObject]{
                        //Title
                        if let title = fullName["title"] as? String{
                            print(title)
                        }
                        //First name
                        if let firstName = fullName["first"] as? String{
                            print(firstName);
                            person?.firstName = firstName;
                        }
                        //Last name
                        if let lastName = fullName["last"] as? String{
                            person?.lastName = lastName;
                            print(lastName);
                            
                        }
                        if let picture = field["picture"] as? [String : AnyObject]{
                            if let imageURL = picture["large"] as? String{
                                person?.imageURL = imageURL;
                                print(imageURL);
                            }
                        }
                    }
                    databaseHelperInstance.create(firstname: (person?.firstName)!, lastname: (person?.lastName)!,image: (person?.imageURL)!)
                }
            }
        }
    }
}


