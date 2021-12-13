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
        
//        restaurantNameLabel.text = restaurant["restaurant_name"] as? String
//        priceLabel.text = restaurant["price_range"] as? String
//        hoursLabel.text = restaurant["hours"] as? String
//        cuisineLabel.text = restaurant["cuisine"][0] as? String
//        addressLabel.text = restaurant["address"]["formatted"] as? String
//
        
        let restaurant_name = restaurant["restaurant_name"] as! String
        let price_range = restaurant["price_range"] as! String
        let hours = restaurant["hours"] as! String
        let cuisines = restaurant["cuisines"] as! [String]
        //let address = restaurant["address"]
       
        restaurantNameLabel!.text = restaurant_name
        
        if price_range != "" {
           priceLabel!.text = price_range
        } else {
           priceLabel!.text = "Unavailable"
        }
        
        if hours != "" {
            hoursLabel!.text = hours
        } else {
            hoursLabel!.text = "Unavailable"
        }
        
        if cuisines[0] != "" {
            cuisineLabel!.text = cuisines[0]
        } else {
            cuisineLabel!.text = "Unavalable"
        }
//        addressLabel!.text = address["formatted"] as! String
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
