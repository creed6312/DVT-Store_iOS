//
//  featuredProduct.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2016/02/12.
//  Copyright © 2016 DVT. All rights reserved.
//

import Foundation
import UIKit

public class FeaturedProduct{
    var name:String
    var price: Double
    var description: String
    var productImage: UIImage
    
    public init(name:String,price: Double,description: String,productImage: UIImage)
    {
        
        self.description = description
        self.name = name
        self.price = price
        self.productImage = productImage
        
    }
    
    
}
