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
        
              
        
    }

    @IBAction func GoBackToPreviousPage(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    @IBAction func addToCart(sender: UIButton) {
        
        
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
