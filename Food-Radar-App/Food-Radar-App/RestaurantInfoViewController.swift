//
//  RestaurantInfoViewController.swift
//  Food-Radar-App
//
//  Created by Brang Mai on 12/6/21.
//

import UIKit

class RestaurantInfoViewController: UIViewController {
    var restaurant: [String:Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(restaurant["restaurant_name"])
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
