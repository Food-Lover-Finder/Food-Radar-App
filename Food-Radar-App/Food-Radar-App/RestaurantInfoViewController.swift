//
//  RestaurantInfoViewController.swift
//  Food-Radar-App
//
//  Created by Brang Mai on 12/6/21.
//

import UIKit

class RestaurantInfoViewController: UIViewController {
    
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var restaurant: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        restaurantNameLabel.text = restaurant["restaurant_name"] as? String
        priceLabel.text = restaurant["price_range"] as? String
        hoursLabel.text = restaurant["hours"] as? String
//        cuisineLabel.text = restaurant["cuisine"][0] as? String
//        addressLabel.text = restaurant["address"]["formatted"] as? String
        phoneLabel.text = restaurant["restaurant_phone"] as? String
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
