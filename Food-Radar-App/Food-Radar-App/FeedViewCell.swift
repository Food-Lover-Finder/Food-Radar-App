//
//  FeedViewCell.swift
//  Food-Radar-App
//
//  Created by Brang Mai on 11/20/21.
//

import UIKit

class FeedViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var hours: UILabel!    
    @IBOutlet weak var cuisine: UILabel!
    
    //    @IBOutlet weak var restaurantName: UILabel!
//    @IBOutlet weak var priceRange: UILabel!
//    @IBOutlet weak var hours: UILabel!
//    @IBOutlet weak var phone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func moreInfo(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
