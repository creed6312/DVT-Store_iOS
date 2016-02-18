//
//  ViewController.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2016/02/12.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    //Mark: Featured Products view properties
    
    @IBOutlet weak var featuredItem: UIImageView!
    @IBOutlet weak var featuredProductName: UILabel!
    @IBOutlet weak var featuredProductPrice: UILabel!
    @IBOutlet weak var featuredProductDescription: UITextView!
    
    @IBOutlet weak var productTableView: UITableView!
    
    //Mark: TableView items
    
    
    
    @IBOutlet weak var viewForFeaturedItem: UIView!
    
    //Mark: properties
    
    var products = [FeaturedProduct]()
    let photo1 = UIImage(named: "mac1.jpg")
    let photo2 = UIImage(named: "mac2.jpg")
    let photo3 = UIImage(named: "iphone1.jpg")
    let photo4 = UIImage(named: "iphone2.jpg")
    var imageTemp = UIImage(named: "mac1.jpg")
    var tempCounter: Int = 0
    
    var progressView: UIProgressView?
    var progressLabel: UILabel?

    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    
    
    let manager = ProductDataSource()
    var myproducts = [FeaturedProduct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //manager.getProducts(&self.myproducts)
        
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        jsonParser("GetFeatured",Type: "featured")
        jsonParser("GetAllProducts",Type: "not")
        //loopThroughObject(products, counter: tempCounter)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //showing product details in another view controllertab
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("productDescription:"))
        featuredItem.userInteractionEnabled = true
        featuredItem.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView,numberOfRowsInSection section:Int)-> Int
    {
        return self.myproducts.count
    }
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell
    {
        let tempProduct = self.myproducts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("featuredProductCell") as? ProductsTableViewCell
        cell!.productName?.text = tempProduct.name
        cell!.productPrice.text = "R" + String(tempProduct.price)
        cell!.productImage.image = tempProduct.productImage
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        //123
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! ProductsTableViewCell
        
        selectedProductImage = currentCell.productImage.image
        selectedProductName = currentCell.productName.text
        selectedProductPrice = currentCell.productPrice.text
        selectedProductDescription = currentCell.productName.text
       
        performSegueWithIdentifier("featured", sender: self)
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "featured"
        {
          
             print("this is our product " , myproducts)
            
             if let destinationVC = segue.destinationViewController as? DetailViewController
             {
                destinationVC.name =  selectedProductName
                destinationVC.image = selectedProductImage
                destinationVC.price = selectedProductPrice
                destinationVC.desc = selectedProductDescription
            }
            
        }
    }
    
    
    func createClasses()
    {
        
        
        let featuredProduct = FeaturedProduct(name: "Laptop",price: 18000.00,description: "This product",productImage: imageTemp!,url: " url",id: 127)
        let featuredProduct2 = FeaturedProduct(name: "Laptop2",price: 22000.00,description: "This product",productImage: photo2!,url: "url",id: 125)
        let featuredProduct3 = FeaturedProduct(name: "iphone1",price: 8500.00,description: "This product",productImage: photo3!,url: "url",id: 123)
        let featuredProduct4 = FeaturedProduct(name: "iphone2",price: 6500.00,description: "This product fghdfgsdlfjdhsflkdslkf sdlkfhkljsdhfkldshlk fsdklnvfjksdghtlskdnvlkdfsjgklsdjfl;jds;lfjk;lsdfdskl;jfosd f;kdsjflksdjfkldsj flisdjkfklsdhtkldasjflksdfjklsdjfklds",productImage: photo4!,url: "url",id: 122)
        
        
        products += [featuredProduct,featuredProduct2, featuredProduct3, featuredProduct4 ]
        
    }
    
    func loadProductDataInUIComponents(f:FeaturedProduct)
    {
        
        featuredProductName.text = f.name
        featuredProductPrice.text = String (f.price)
        featuredProductDescription.text = f.description
        featuredItem.image = f.productImage
        
    }
    
    func jsonParser(Call : String, Type : String)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://dvtstorage.cloudapp.net/api/" + Call + "?ApiToken=" + self.ApiKey
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do
                {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    var count = 0
                    for object in jsonDictionary as! [NSObject]
                    {
                        let id: Int = object.valueForKey("Id") as! Int
                        let name: String = object.valueForKey("Name") as! String
                        let descrip: String = object.valueForKey("Description") as! String
                        let price: Double = object.valueForKey("Price") as! Double
                        let imageLink: String = object.valueForKey("Url") as! String
                        let url = NSURL(string: imageLink)
                        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                        self.imageTemp = UIImage(data: data!)
                        print("ID: " + String(id))
                        print("Name: " + name)
                        print("Description: " + descrip)
                        print("Price: " + String(format:"%.2f", price))
                        let prod = FeaturedProduct(name: name,price: price,description: descrip,productImage: self.imageTemp!,url: imageLink,id: id)
                        
                        if (Type == "featured")
                        {
                            self.products += [prod]
                        }
                        else
                        {
                            self.myproducts += [prod]
                            
                        }
                        
                        count++
                        print(imageLink)
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            self.productTableView.reloadData()
                            self.loadProductDataInUIComponents(self.products[0])
                    }
                }
                catch {
                    print(error)
                }
                }.resume()
            
        }
    }
    
    @IBAction func swipethroughFeaturedItem(sender: UISwipeGestureRecognizer) {
        
        if(sender.direction == .Left){
            tempCounter += 1
            if (tempCounter == products.count)
            {
                tempCounter = 0
            }
            loadProductDataInUIComponents(products[tempCounter])
        }
            
        else if(sender.direction == .Right){
            tempCounter += -1
            if (tempCounter < 0 )
            {
                tempCounter = products.count - 1
            }
            loadProductDataInUIComponents(products[tempCounter])
        }
    }
    
    //    func productDescription(image: AnyObject)
    //    {
    //        self.performSegueWithIdentifier("GoToViewController", sender:self)
    //    }
    
}

