//
//  CartViewController.swift
//  DVT-Store_iOS
//
//  Created by DVT on 3/6/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{

    
 
    @IBOutlet weak var cartTableView: UITableView!
    
    //Mark: TableView items
    
    @IBOutlet weak var totalLable: UILabel!
    var selectedProductImage:UIImage!
    var selectedProductName:String!
    var selectedProductPrice: String!
    var selectedProductDescription:String!
    
    var selectedProductID:Int!
    //Mark: featuredProducts items
    
    var total: Double = 0.00;
    
    
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
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addToolBar(2)
        self.cartTableView.delegate = self
        self.cartTableView.dataSource = self
        
        //spinner?.startAnimating()
        jsonParser("GetCart")
        //jsonParser("GetFeatured",Type: "featured")
        //loadBasketData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
       // let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("featuredClick:"))
        //featuredProductView.userInteractionEnabled = true
        //featuredProductView.addGestureRecognizer(tapGestureRecognizer)
        
     
        
        let emptySrting:String = ""
        if(!tempString.isEmpty){
                tempString = emptySrting
        
        }
      
       
        
    }
    
    func loadList(notification: NSNotification){
       // self.featuredProductView.alpha = 0.99
       // loadProductDataInUIComponents(products[tempCounter])
    }
    
    func featuredClick(sender: UITapGestureRecognizer)
    {
        //self.featuredProductView.alpha = 0.99
        performSegueWithIdentifier("featured", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView,numberOfRowsInSection section:Int)-> Int
    {
        return self.myproducts.count
    }
    var tempTotal : [Double] = []
    
    var totalFianl: Double = 0.00
    
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell
    {
        let tempProduct = self.myproducts[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cartViewCell") as? cartViewCell
        cell!.cartTitle?.text = tempProduct.name
        cell!.cartPrice.text = "R" + String(format:"%.2f", myproducts[indexPath.row].price)
        cell!.cartImage.image = tempProduct.productImage
        cell!.cartQuantity.text = String(BasketUtility.basketList[indexPath.row].BasketCount)
        cell!.id = indexPath.row
       
        if(indexPath.row > 0)
        {
            tempTotal.append((tempPrice[indexPath.row] * Double(BasketUtility.basketList[indexPath.row].BasketCount)) +
            tempTotal[indexPath.row - 1])
            
        }else
        {
            
            tempTotal.append(tempPrice[indexPath.row] * Double(BasketUtility.basketList[indexPath.row].BasketCount))
            
        }
        
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
        totalLable.text = "Total: " +  	String(format: "%.2f", tempTotal[indexPath.row])
        
        
        
        return cell!
    }
    
  
    var totalas: Double=0.00
    func gettotal()
    {
       
       
        print("**value as" + String(tempTotal.count))
        
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
    
    var tempPrice : [Double] = []
    
     var tempString :String = ""
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
        
                
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlPath = "http://creed.ddns.net:14501/api/" + Call + "?Ids=" + self.tempString + "&ApiToken=" + self.ApiKey
            guard let endpoint = NSURL(string: urlPath) else { print("Error creating endpoint");return }
            let request = NSMutableURLRequest(URL:endpoint)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
                do
                {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    
                  
                        self.productsCount = jsonDictionary.count
                  
                        self.featuredProductsCount = jsonDictionary.count
                    
                    
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
                        self.tempPrice.append(price)
                        let prod = FeaturedProduct(name: name,price: price,description: descrip,productImage:imageTemp!,id: id)
                        
                      
                            self.products += [prod]
                        
                            self.myproducts += [prod]
                        
                        
                      
                    }
                    
                    dispatch_async(dispatch_get_main_queue())
                        {
                            if (self.myproducts.count == self.productsCount && self.products.count == self.featuredProductsCount)
                            {
                                
                                self.cartTableView.reloadData()
                                self.cartTableView.hidden = false
                               
                                
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
            //loadProductDataInUIComponents(products[tempCounter])
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
           // loadProductDataInUIComponents(products[tempCounter])
        }
            
        else if(sender.direction == .Right){
            tempCounter += -1
            if (tempCounter < 0 )
            {
                tempCounter = products.count - 1
            }
            //loadProductDataInUIComponents(products[tempCounter])
        }
    }
    
    func addToolBar(itemnumberIluminate : Int){
        
        var arrayofitems: [UIBarButtonItem] = []
        
        let toolBar = UIToolbar()
        toolBar.frame = CGRectMake(0, self.view.frame.size.height - 46, self.view.frame.size.width, 46)
        toolBar.sizeToFit()
        toolBar.barStyle = UIBarStyle.Default
        
        
        // MARK: UiComponent
        
        let homeItem = UIBarButtonItem(image: UIImage(named: "house.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toHomePreassed")
        
        let mapItem = UIBarButtonItem(image: UIImage(named: "map.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toMapsPreassed")
        
        let listItams = UIBarButtonItem(image: UIImage(named: "order.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toListPreassed")
        let cartItem = UIBarButtonItem(image: UIImage(named: "cart.png"), style: UIBarButtonItemStyle.Plain, target: self, action: "toCartPreassed")
        
        let space = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        
        arrayofitems.append(homeItem)
        arrayofitems.append(listItams)
        arrayofitems.append(cartItem)
        arrayofitems.append(mapItem)
        
        
        for index in arrayofitems
        {
            index.tintColor = UIColor.grayColor()
        }
        
        
        switch (itemnumberIluminate)
        {
        case 0:
            arrayofitems[0].tintColor = nil
        case 1:
            arrayofitems[1].tintColor = nil
        case 2:
            arrayofitems[2].tintColor = nil
        case 3:
            arrayofitems[3].tintColor = nil
        default:
            arrayofitems[itemnumberIluminate].tintColor = UIColor.grayColor()
            
        }
        
        
        toolBar.setItems([homeItem, space, listItams, space, cartItem, space, mapItem], animated: false)
        
        toolBar.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(toolBar)
        
        
    }
    
    
    func toHomePreassed(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("MainView") as! ViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
        print("To home pressed")
    }
    
    func toListPreassed(){
        print("To list pressed")
    }
    
    func toCartPreassed(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("cartView") as! CartViewController
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
        print("To cart pressed")
    }
    
    func toMapsPreassed(){
        print("To map pressed")
    }

    func toCheckoutPage(){
    
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("checkoutView") as! CheckOutUIControllers
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func toCheckout(sender: AnyObject) {
       toCheckoutPage()
    }
    
   
}

