//
//  DetailViewController.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2/15/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var featuredProduct: FeaturedProduct!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navigationBar: UINavigationBar!
   
    @IBOutlet weak var itemCountStepper: UIStepper!
    @IBOutlet weak var cartItemCount: UITextView!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var detailView: UIView!
    
    var name : String!
    var price : String!
    var desc : String!
    var id: Int!
    var cartCount : Int = 0
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemCountStepper.hidden = true
        cartItemCount.hidden = true
        
        productName.text = name
        productImage.image = image
        productPrice.text = price
        
        
        itemCountStepper.value = 0
        cartCount = 0
        checkQuantity()
        
        //let myAttributes = [NSFontAttributeName: UIFont(name: "Arial", size: 15.0)!]
//        
//       // do{
//        let str = try NSAttributedString(data : desc.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options:/[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],documentAttributes:nil)
//            
//            productDescription.attributedText = str
//        }catch{
//            print("done")
//        }
        productDescription.text = desc
        let fixedWidth = productDescription.frame.size.width
        productDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = productDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = productDescription.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        scrollView.frame = newFrame;
    }

    @IBAction func GoBackToPreviousPage(sender: UIBarButtonItem) {
        
         NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        productDescription.sizeToFit()
        scrollView.sizeToFit()
        detailView.sizeToFit()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    @IBAction func addToCart(sender: UIButton) {
        itemCountStepper.hidden = false
        cartItemCount.hidden = false
        addToCartBtn.hidden = true
    
        itemCountStepper.value = 1
        cartCount = 1
        cartItemCount.text = "1"
        
        let bi = BasketItem()
        bi.BasketCount = 1
        bi.BasketId = id
        BasketUtility.basketList.append(bi)
        print( bi.BasketId)
        savePlaces()
    }
    
    @IBAction func stepperAction(sender: AnyObject) {
        
        
        var amount = 0
        if (cartCount < (Int(itemCountStepper.value)))
        {
            amount = 1
        }
        else
        {
           amount = -1
        }
        
        cartCount = Int(itemCountStepper.value)
        
        cartItemCount.text = String(Int(itemCountStepper.value))
        
        for i in 0...BasketUtility.basketList.count-1
        {
                if(BasketUtility.basketList[i].BasketId == id)
                {
                    if (BasketUtility.basketList[i].BasketCount == 1 && amount == -1 )
                    {
                        BasketUtility.basketList.removeAtIndex(i)
                    }
                    else
                    {
                        BasketUtility.basketList[i].BasketCount += amount
                        print( BasketUtility.basketList[i].BasketCount )
                    }
                    break
                }
        }
        
        if(itemCountStepper.value < 1)
        {
            itemCountStepper.hidden = true
            cartItemCount.hidden = true
            addToCartBtn.hidden = false
        }
        savePlaces()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func savePlaces(){
        
        var BasketId: [NSInteger] = [NSInteger]()
        var BasketCount: [NSInteger] = [NSInteger]()
        
        if (BasketUtility.basketList.count > 0)
        {
            for i in 0...BasketUtility.basketList.count-1
            {
                BasketId.append(BasketUtility.basketList[i].BasketId)
                BasketCount.append(BasketUtility.basketList[i].BasketCount)
            }
        }
        else
        {
            
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(BasketId, forKey: "BasketID")
        defaults.synchronize()
        
        defaults.setObject(BasketCount, forKey: "BasketCount")
        defaults.synchronize()
    }
    
    func checkQuantity()
    {
        if (BasketUtility.basketList.count > 0)
        {
        for i in 0...BasketUtility.basketList.count-1
        {
            if (BasketUtility.basketList[i].BasketId == id)
            {
                itemCountStepper.hidden = false
                cartItemCount.hidden = false
                addToCartBtn.hidden = true
                
                itemCountStepper.value = Double( BasketUtility.basketList[i].BasketCount)
                cartItemCount.text = String( BasketUtility.basketList[i].BasketCount)
                cartCount = BasketUtility.basketList[i].BasketCount
                
                break
            }
        }
        }
    }
    
}













