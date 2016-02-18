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
    
   
    @IBOutlet weak var detailView: UIView!
    
    
    var name : String!
    var price : String!
    var desc : String!
    
    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        productName.text = name
        productImage.image = image
        productPrice.text = price
        productDescription.text = desc
        
        let fixedWidth = productDescription.frame.size.width
        productDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = productDescription.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = productDescription.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        scrollView.frame = newFrame;
        
        
        print("Resizing LAbel")
               print("RLAbel resized")
        
       
        
    }

    @IBAction func GoBackToPreviousPage(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
//        productDescription.numberOfLines = 0
//        productDescription.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //productDescription.frame = CGRectMake(8, 100, 268, CGFloat(292424))
        productDescription.sizeToFit()
        scrollView.sizeToFit()
        detailView.sizeToFit()
       // detailView.frame.height = productDescription.frame.height
        
        
        
        

        
    }
    
    
    
    @IBAction func addToCart(sender: UIButton) {
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
              // Dispose of any resources that can be recreated.
    }
    
    
    
}
