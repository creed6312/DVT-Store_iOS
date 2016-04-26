//
//  cartViewCell.swift
//  DVT-Store_iOS
//
//  Created by DVT on 3/6/16.
//  Copyright © 2016 DVT. All rights reserved.
//

import UIKit

class cartViewCell: UITableViewCell {

    
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var cartTitle: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    
    @IBOutlet weak var cartQuantity: UILabel!
    @IBOutlet weak var cartStepper: UIStepper!
    
    
    
    var id: Int!
    
    
    var cartCount : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
            }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.cartStepper.value = Double(cartQuantity.text!)!

    }
    
    @IBAction func stepperAction(sender: UIStepper) {
       
       
       
      
        var amount = 0
        //cartStepper.value = Double()
        
        print("****"  +  String(amount))
     
       
        if (cartCount <= (Int(cartStepper.value)))
        {
            amount = 1
        }
        else
        {
        
            amount = 1
        }
        
        cartCount = Int(cartStepper.value)
        
        cartQuantity.text = String(Int(cartStepper.value))
        
       
        BasketUtility.basketList[id].BasketCount = Int(cartQuantity.text!)!
        print( BasketUtility.basketList[id].BasketCount )
        
      
        
        

        savePlaces()
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

}
