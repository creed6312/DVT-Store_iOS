//
//  JSonAPICalls.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2016/02/17.
//  Copyright © 2016 DVT. All rights reserved.
//

import Foundation
import UIKit
class JsonApiCalls
{
    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    
    
    
    init()
    {
        
        
    }
    let photo4 = UIImage(named: "iphone2.jpg")
    
    
    func post(completion: (message: String?, p : [FeaturedProduct]?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://stackoverflow.com")!)
        request.HTTPMethod = "POST"
        
        let postString = "data=xxxxxxx"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            completion(message: NSString(data: data!, encoding: NSUTF8StringEncoding) as? String, p : [FeaturedProduct]() as? [FeaturedProduct])
        }
        
        task.resume()
    }
    
    func completionHandler(Call : String?, p: [FeaturedProduct]?){
        print("I got " + Call!)
    }
    
    func jsonParser(Call : String, inout p: [FeaturedProduct])
    {
        
        let urlPath = "http://dvtstorage.cloudapp.net/api/" + Call + "?ApiToken=" + ApiKey
        guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
        let request = NSMutableURLRequest(URL:endpoint)
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                var count = 0
                for object in jsonDictionary as! [NSObject] {
                    
                    
                    let id: Int = object.valueForKey("Id") as! Int
                    let name: String = object.valueForKey("Name") as! String
                    let descrip: String = object.valueForKey("Description") as! String
                    let price: Double = object.valueForKey("Price") as! Double
                    let imageLink: String = object.valueForKey("Url") as! String
                    let url = NSURL(string: imageLink)
                    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                    let imageTemp = UIImage(data: data!)
                    print("ID: " + String(id))
                    print("Name: " + name)
                    print("Description: " + descrip)
                    print("Price: " + String(format:"%.2f", price))
                    let prod = FeaturedProduct(name: name,price: price,description: descrip,productImage: imageTemp!,url: imageLink,id: id)
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            // now update UI on main thread
                            p.append(prod)
                            
                        }
                    }
                    count++
                    print(imageLink)}
            } catch {
                
                print(error)
            }
            }.resume()
        
    }
}