//
//  checkoutUIController.swift
//  DVT-Store_iOS
//
//  Created by DVT on 3/10/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import Foundation
import UIKit
class CheckOutUIControllers : UIViewController
{
    
    @IBOutlet weak var totalCost: UITextView!
    @IBOutlet weak var OrderID: UITextView!
    
    @IBOutlet weak var totlat: UITextView!
    
    @IBOutlet weak var tick: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        jsonParser("CheckOut")
    }
    
    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    var tempString :String = ""
    
    var tempCountString: String = ""
    func jsonParser(Call : String)
    {
        
        
        
        print(String(BasketUtility.basketList.count) + " basket")
        for i in 0...BasketUtility.basketList.count - 1
        {
            
            
            
            if(i < BasketUtility.basketList.count - 1)
            {
                if(BasketUtility.basketList[i].BasketId != 0){
                    tempString += String(BasketUtility.basketList[i].BasketId) + ","
                }
            }else
            {
                
                if(BasketUtility.basketList[i].BasketId != 0){
                    tempString += String(BasketUtility.basketList[i].BasketId)
                }
                if(tempString.characters.last! == ",")
                {
                    tempString = tempString.substringToIndex(tempString.endIndex.predecessor())
                    
                }
            }
            
            // print( "asasd" +  tempString)
            
        }
        
        for i in 0...BasketUtility.basketList.count - 1
        {
            
            
            
            if(i < BasketUtility.basketList.count - 1)
            {
                if(BasketUtility.basketList[i].BasketId != 0){
                    tempCountString += String(BasketUtility.basketList[i].BasketCount) + ","
                }
            }else
            {
                
                if(BasketUtility.basketList[i].BasketId != 0){
                    tempCountString += String(BasketUtility.basketList[i].BasketCount)
                }
                if(tempCountString.characters.last! == ",")
                {
                    tempCountString = tempCountString.substringToIndex(tempString.endIndex.predecessor())
                    
                }
            }
            
             print( "asasd" +  tempCountString)
            
        }

        
        
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://creed.ddns.net:14501/api/" + Call + "?Ids=" + self.tempString  + "&qtys=" + self.tempCountString + "&ApiToken=" + self.ApiKey
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do
                {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSObject
                   
                    
                    
                  
                        let id: Int = jsonDictionary.valueForKey("Id") as! Int
                        let total: Double = jsonDictionary.valueForKey("Total") as! Double
                        let quantity: Int = jsonDictionary.valueForKey("Count") as! Int
                        
                        print("ID: " + String(id))
                        print("Name: " + String(total))
                        print("Description: " + String(quantity))
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.OrderID.text = String(id)
                            self.totalCost.text = String(total)
                            self.totlat.text = String(quantity)
                            
                            print("-------")
                            
                    }
                    
                    
                    
                    
                }
                catch {
                    print(error)
                }
                }.resume()
            
        }
        
        
    }
}
