//
//  ProductDataSource.swift
//  DVT-Store_iOS
//
//  Created by DVT on 2016/02/15.
//  Copyright © 2016 DVT. All rights reserved.
//

import Foundation
import UIKit

class ProductDataSource{
    
    var products:[FeaturedProduct]
    
    let photo1 = UIImage(named: "mac1.jpg")
    let photo2 = UIImage(named: "mac2.jpg")
    let photo3 = UIImage(named: "iphone1.jpg")
    let photo4 = UIImage(named: "iphone2.jpg")
    
    init()
    {
        products = []
        let product1 = FeaturedProduct(name: "MacBook Pro", price: 21000.00, description: "Product made by Apple", productImage: photo1!, url: "Find this product here", id: "x1234abc")
        products.append(product1)
        
        let product2 = FeaturedProduct(name: "MacBook Pro2", price: 27000.00, description: "Product made by Apple", productImage: photo2!, url: "Find this product here", id: "x1234abc")
        products.append(product2)
        
        let product3 = FeaturedProduct(name: "Iphone 5S", price: 9000.00, description: "Product made by Apple", productImage: photo3!, url: "Find this product here", id: "x1234abc")
        products.append(product3)
        
        let product4 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: "x1234abc")
        products.append(product4)
        
    }
    func getProducts() ->[FeaturedProduct]
    {
        return products
    }
    
    
}
