//
//  ViewController.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2016/02/12.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
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
    var tempCounter: Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let featuredProduct = FeaturedProduct(name: "Laptop",price: 28000.00,description: "This product",productImage: photo1!,url: " url",id: "12 ")
        let featuredProduct2 = FeaturedProduct(name: "Laptop2",price: 22000.00,description: "This product",productImage: photo2!,url: "url",id: "123")
        let featuredProduct3 = FeaturedProduct(name: "iphone1",price: 8500.00,description: "This product",productImage: photo3!,url: "url",id: "1234")
        let featuredProduct4 = FeaturedProduct(name: "iphone2",price: 6500.00,description: "This product fghdfgsdlfjdhsflkdslkf sdlkfhkljsdhfkldshlk fsdklnvfjksdghtlskdnvlkdfsjgklsdjfl;jds;lfjk;lsdfdskl;jfosd f;kdsjflksdjfkldsj flisdjkfklsdhtkldasjflksdfjklsdjfklds",productImage: photo4!,url: "url",id: "23423")
        
        products += [featuredProduct,featuredProduct2, featuredProduct3, featuredProduct4 ]
        
        //loadProductDataInUIComponents(products)
        loopThroughObject(products, counter: tempCounter)
    
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //showing product details in another view controller
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("productDescription:"))
        featuredItem.userInteractionEnabled = true
        featuredItem.addGestureRecognizer(tapGestureRecognizer)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func loadProductDataInUIComponents(f:FeaturedProduct)
    {
    
        featuredProductName.text = f.name
        featuredProductPrice.text = String (f.price)
        featuredProductDescription.text = f.description
        featuredItem.image = f.productImage
    
    }
    func loopThroughObject(f:[FeaturedProduct], counter:Int)
    {
        
        if (tempCounter == products.count){
            tempCounter = 0
            loadProductDataInUIComponents(products[tempCounter])
            print(tempCounter)
             print(products.count)        }
        else{
            
            loadProductDataInUIComponents(products[counter])
            tempCounter++
            
        }
    }
    
    @IBAction func swipethroughFeaturedItem(sender: UISwipeGestureRecognizer) {
        
        
        
        if(sender.direction == .Left){
            
            loopThroughObject(products,counter: tempCounter)
            print(tempCounter)
            print(products.count)
        }
        
        else if(sender.direction == .Right){
            
            loopThroughObject(products,counter: tempCounter)
            
        }
    }
    
    
    func productDescription(image: AnyObject)
    {
        self.performSegueWithIdentifier("GoToViewController", sender:self)
    }
    
    func numberOfSelectionInTableView(tableView: UITableView)->Int
    {
    
        return 0
    }
     func numberOfSelectionInTableView(tableView: UITableView,numberOfRowsSection section:Int)-> Int
    {
        return products.count
    }
    func numberOfSelectionInTableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath)->UITableViewCell
    {
        let cellIdentifier = "ProductsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ProductsTableViewCell
        
        //let productCell = FeaturedProduct[indexPath.row]
       if let p = FeaturedProduct[indexPath.row] as? Activity
       {
        
        }
        
        
        
        return cell
    }



}

