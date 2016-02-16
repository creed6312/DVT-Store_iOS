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
    var tempCounter: Int = 0
    
    var selectedProductImage:UIImage!
    var selectedProductName:String!
    var selectedProductPrice: String!
    var selectedProductDescription:String!
    
    var counter = 0
    
    let manager = ProductDataSource()
    var myproducts = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productTableView.delegate = self
        self.productTableView.dataSource = self
        self.myproducts = manager.getProducts()
        
        
        
        createClasses()
        loopThroughObject(products, counter: tempCounter)
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
        let tempProduct = self.myproducts[indexPath.row] as? FeaturedProduct
        let cell = tableView.dequeueReusableCellWithIdentifier("featuredProductCell") as? ProductsTableViewCell
        cell!.productName?.text = tempProduct?.name
        cell!.productPrice.text = String(tempProduct!.price)
        cell!.productImage.image = tempProduct?.productImage
        cell!.selectionStyle = UITableViewCellSelectionStyle.None
        
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
        let featuredProduct = FeaturedProduct(name: "Laptop",price: 28000.00,description: "This product",productImage: photo1!,url: " url",id: "12 ")
        let featuredProduct2 = FeaturedProduct(name: "Laptop2",price: 22000.00,description: "This product",productImage: photo2!,url: "url",id: "123")
        let featuredProduct3 = FeaturedProduct(name: "iphone1",price: 8500.00,description: "This product",productImage: photo3!,url: "url",id: "1234")
        let featuredProduct4 = FeaturedProduct(name: "iphone2",price: 6500.00,description: "This product fghdfgsdlfjdhsflkdslkf sdlkfhkljsdhfkldshlk fsdklnvfjksdghtlskdnvlkdfsjgklsdjfl;jds;lfjk;lsdfdskl;jfosd f;kdsjflksdjfkldsj flisdjkfklsdhtkldasjflksdfjklsdjfklds",productImage: photo4!,url: "url",id: "23423")
        
        products += [featuredProduct,featuredProduct2, featuredProduct3, featuredProduct4 ]
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

}

