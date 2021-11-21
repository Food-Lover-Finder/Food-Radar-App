//
//  FeedViewCell.swift
//  Food-Radar-App
//
//  Created by Brang Mai on 11/20/21.
//

import UIKit

class FeedViewCell: UITableViewCell {
    
    @IBOutlet weak var restaurantPicture: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var cuisineType: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
