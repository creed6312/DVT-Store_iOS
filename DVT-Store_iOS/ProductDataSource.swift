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
    
    //var products:[FeaturedProduct]
    
    let photo1 = UIImage(named: "mac1.jpg")
    let photo2 = UIImage(named: "mac2.jpg")
    let photo3 = UIImage(named: "iphone1.jpg")
    let photo4 = UIImage(named: "iphone2.jpg")
    
    var parser = JsonApiCalls()

    
    init()
    {
    
        
        

//        let product2 = FeaturedProduct(name: "MacBook Pro2", price: 27000.00, description: "Product made by Apple", productImage: photo2!, url: "Find this product here", id: 12345)
//        
//        products.append(product2)
////        
//       let product3 = FeaturedProduct(name: "Iphone 5S", price: 9000.00, description: "Product made by Apple", productImage: photo3!, url: "Find this product here", id: 12346)
//        products.append(product3)
//
//        let product4 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 123467)
//        products.append(product4)
//        let product5 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 12348)
//        products.append(product5)
//        let product6 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 57678)
//        products.append(product6)
//        let product7 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 1234)
//        products.append(product7)
//        let product8 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 69879)
//        products.append(product8)
//        let product9 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 456898)
//        products.append(product9)
//        let product10 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 905444)
//        products.append(product10)
        
    }
    func getProducts(inout p:[FeaturedProduct])
    {
        
        //let product10 = FeaturedProduct(name: "IPhone 6S", price: 12000.00, description: "Product made by Apple", productImage: photo4!, url: "Find this product here", id: 905444)
       // p.append(product10)
       // parser.jsonParser("GetAllProducts", p: &p)
     }
    
    
}
