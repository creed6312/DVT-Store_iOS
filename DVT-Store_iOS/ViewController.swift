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
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var pageIndicator: UIPageControl!
    @IBOutlet weak var featuredItem: UIImageView!
    @IBOutlet weak var featuredProductName: UILabel!
    @IBOutlet weak var featuredProductPrice: UILabel!
    @IBOutlet weak var featuredProductDescription: UITextView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var featuredProductView: UIView!
    
    //Mark: TableView items
    
    var selectedProductImage:UIImage!
    var selectedProductName:String!
    var selectedProductPrice: String!
    var selectedProductDescription:String!
    
    var selectedProductID:Int!
    //Mark: featuredProducts items
    
    
    
    //Mark: properties
    
    var products = [FeaturedProduct]()
    var tempCounter: Int = 0
    var timerWait = false
    
    var progressView: UIProgressView?
    var progressLabel: UILabel?
    
    var myTimer = NSTimer.self
    
    let ApiKey:String = "0ac44d4d-eb43-3e0e-fb86-ba427bee5eb4"
    
    var featuredProductsCount : Int = -1
    var productsCount : Int = -1
    let manager = ProductDataSource()
    var myproducts = [FeaturedProduct]()
    
    func loadBasketData(){
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let basketArr : AnyObject? = defaults.objectForKey("BasketID")
        {
            if (basketArr?.count > 0 )
            {
                var readArr: [NSInteger] = basketArr as! [NSInteger]
                for i in 0...readArr.count-1
                {
                    let g = BasketItem()
                    BasketUtility.basketList.append(g)
                    BasketUtility.basketList[i].BasketId = readArr[i]
                    print(BasketUtility.basketList[i].BasketId)
                }
            }
        }
        if let basketCount : AnyObject? = defaults.objectForKey("BasketCount")
        {
            if (basketCount?.count > 0)
            {
                var readArr: [NSInteger] = basketCount as! [NSInteger]
                for i in 0...readArr.count-1
                {
                    BasketUtility.basketList[i].BasketCount = readArr[i]
                    print(BasketUtility.basketList[i].BasketCount)
                }
            }
        }
        
    }
    
    func addDots(){
        
        indicatorView.layer.sublayers = nil
        
        for index in 0...featuredProductsCount-1
        {
            let a = CGFloat((featuredProductsCount * (-12)) + (index * 20))
            let circle = UIBezierPath(ovalInRect: CGRectMake(a, 10, 8, 8))
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circle.CGPath
            
            shapeLayer.strokeColor = UIColor.blueColor().CGColor
            if (tempCounter == index )
            {
                shapeLayer.fillColor = UIColor.blueColor().CGColor
            }
            else
            {
                shapeLayer.fillColor = UIColor.whiteColor().CGColor
            }
            indicatorView.layer.addSublayer(shapeLayer)
        }
        
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        
        spinner?.startAnimating()
        jsonParser("GetAllProducts",Type: "not")
        jsonParser("GetFeatured",Type: "featured")
        loadBasketData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("featuredClick:"))
        featuredProductView.userInteractionEnabled = true
        featuredProductView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func loadList(notification: NSNotification){
        self.featuredProductView.alpha = 0.99
        loadProductDataInUIComponents(products[tempCounter])
    }
    
    func featuredClick(sender: UITapGestureRecognizer)
    {
        self.featuredProductView.alpha = 0.99
        performSegueWithIdentifier("featured", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        cell!.productPrice.text = "R" + String(format:"%.2f", myproducts[indexPath.row].price)
        cell!.productImage.image = tempProduct.productImage
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! ProductsTableViewCell
        selectedProductImage = currentCell.productImage.image
        selectedProductName = currentCell.productName.text
        selectedProductPrice = "R" + String(format:"%.2f", myproducts[indexPath.row].price)
        selectedProductDescription = myproducts[indexPath.row].description
        selectedProductID =  myproducts[indexPath.row].ID
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
                destinationVC.id = selectedProductID
            }
        }
        else if segue.identifier == "viewFeatured"
        {
            print("this is our product " , myproducts)
            
            if let destinationVC2 = segue.destinationViewController as? DetailViewController
            {
                destinationVC2.name =  selectedProductName
                destinationVC2.image = selectedProductImage
                destinationVC2.price = selectedProductPrice
                destinationVC2.desc = selectedProductDescription
                destinationVC2.id = selectedProductID
            }
        }
    }
    
    
    
    func loadProductDataInUIComponents(f:FeaturedProduct)
    {
        selectedProductDescription = f.description
        selectedProductImage = f.productImage
        selectedProductName = f.name
        selectedProductPrice = "R" + String(format:"%.2f", f.price)
        selectedProductID = f.ID
        
        
        if (featuredProductView.alpha == 1.0)
        {
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.featuredProductView.alpha = 0.0}, completion:
                {
                    if $0
                    {
                        self.featuredProductName.text = f.name
                        self.featuredProductPrice.text = "R" + String(format:"%.2f", f.price)
                        self.featuredItem.image = f.productImage
                        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {self.featuredProductView.alpha = 1.0}, completion:
                            {
                                if $0
                                {
                                    
                                    self.addDots()
                                    self.featuredProductView.alpha = 1.0
                                }
                        })
                    }
            })
        }
        else
        {
            self.addDots()
            self.featuredProductView.alpha = 1.0
            self.featuredProductName.text = f.name
            self.featuredProductPrice.text = "R" + String(format:"%.2f", f.price)
            self.featuredItem.image = f.productImage
        }
    }
    
    func jsonParser(Call : String, Type : String)
    {
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://dvtstorage.cloudapp.net/api/" + Call + "?ApiToken=" + self.ApiKey
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
                                self.addDots()
                                self.productTableView.reloadData()
                                self.productTableView.hidden = false
                                self.featuredProductView.hidden = false
                                
                                self.loadProductDataInUIComponents(self.products[0])
                                self.spinner?.hidesWhenStopped = true
                                self.spinner?.stopAnimating()
                                
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
    func fire(timer: NSTimer)
    {
        if (!timerWait)
        {
            tempCounter += 1
            if (tempCounter == products.count)
            {
                tempCounter = 0
            }
            loadProductDataInUIComponents(products[tempCounter])
        }
        else
        {
            timerWait = false
        }
    }
    
    @IBAction func swipethroughFeaturedItem(sender: UISwipeGestureRecognizer) {
        
        timerWait = true
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
    
    
}

