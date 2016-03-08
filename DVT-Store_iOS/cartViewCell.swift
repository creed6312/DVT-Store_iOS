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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
