//
//  InterfaceController.swift
//  DVT-Store_watchOS Extension
//
//  Created by DVT on 2016/04/26.
//  Copyright © 2016 DVT. All rights reserved.
//

import WatchKit
import Foundation



class InterfaceController: WKInterfaceController {
    
    @IBOutlet var featuredProductImage: WKInterfaceImage!
    
    @IBOutlet var featuredProductName: WKInterfaceLabel!
    
    @IBOutlet var featuredProductPrice: WKInterfaceLabel!
    
    
    var products = [FeaturedProduct]()
    var tempCounter: Int = 0
    var timerWait = false
    
    
    
    var myTimer = NSTimer.self
    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    
    var featuredProductsCount : Int = -1
    var productsCount : Int = -1
    let manager = ProductDataSource()
    var myproducts = [FeaturedProduct]()

    

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
       
       
        
       
        jsonParser("GetAllProducts",Type: "not")
        jsonParser("GetFeatured",Type: "featured")
       
        
        // Configure interface objects here.
    }
    
    
    
    
    func loadProductDataInUIComponents(f:FeaturedProduct)
    {
//        selectedProductDescription = f.description
//        selectedProductImage = f.productImage
//        selectedProductName = f.name
//        selectedProductPrice = "R" + String(format:"%.2f", f.price)
//        selectedProductID = f.ID
        
            
            self.featuredProductName.setText(f.name)
            self.featuredProductPrice.setText("R" + String(format:"%.2f", f.price))
            self.featuredProductImage.setImage(f.productImage)
        
    }
    
    func jsonParser(Call : String, Type : String)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://creed.ddns.net:14501/api/" + Call + "?ApiToken=" + self.ApiKey
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do
                {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    if (Type != "featured")
                    {
                        self.productsCount = jsonDictionary.count
                    }
                    else
                    {
                        self.featuredProductsCount = jsonDictionary.count
                    }
                    
                    for object in jsonDictionary as! [NSObject]
                    {
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
                        let prod = FeaturedProduct(name: name,price: price,description: descrip,productImage:imageTemp!,id: id)
                        
                        if (Type == "featured")
                        {
                            self.products += [prod]
                        }
                        else
                        {
                            self.myproducts += [prod]
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            if (self.myproducts.count == self.productsCount && self.products.count == self.featuredProductsCount)
                            {
                               
                                
                                self.loadProductDataInUIComponents(self.products[0])
                                
                                
                                self.myTimer.scheduledTimerWithTimeInterval(3.0, target: self,selector: "fire:",userInfo: nil, repeats: true)
                            }
                    }
                    
                }
                catch {
                    print(error)
                }
                }.resume()
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
