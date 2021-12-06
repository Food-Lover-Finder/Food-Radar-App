//
//  FeedViewController.swift
//  Food-Radar-App
//
//  Created by Fatima Javid on 11/5/21.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var homeTableView: UITableView!
    
    var restaurantList = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.dataSource = self
        homeTableView.delegate = self

        // Do any additional setup after loading the view.
//        let url = URL(string: "https://api.documenu.com/v2/restaurant/4072702673999819?key=272dbbb2dd1f1609ae7c84a8a42f6d58")!
        let url = URL(string: "https://api.documenu.com/v2/restaurants/zip_code/11211?size=20&key=272dbbb2dd1f1609ae7c84a8a42f6d58")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.restaurantList = dataDictionary["data"] as! [[String: Any]]
                 print(self.restaurantList)
                 self.homeTableView.reloadData()
             }
        }
        task.resume()
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        PFUser.logOut()
        let main = UIStoryboard(name: "Main", bundle: nil)
        let landingViewController = main.instantiateViewController(withIdentifier: "LandingViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = landingViewController
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "FeedViewCell", for: indexPath) as! FeedViewCell
//        let cell = homeTableView.dequeueReusableCell(withIdentifier: "FeedViewCell") as! FeedViewCell
        let restaurant = restaurantList[indexPath.row]
        let restaurant_name = restaurant["restaurant_name"] as! String
        let price_range = restaurant["price_range"] as! String
        let hours = restaurant["hours"] as! String
        let cuisines = restaurant["cuisines"] as! [String]

        cell.restaurantName!.text = restaurant_name
        
        if price_range != "" {
            cell.priceRange!.text = price_range
        } else {
            cell.priceRange!.text = "Unavailable"
        }
        
        if hours != "" {
            cell.hours!.text = hours
        } else {
            cell.hours!.text = "Unavailable"
        }
        
        if cuisines[0] != "" {
            cell.cuisine!.text = cuisines[0]
        } else {
            cell.cuisine!.text = "Unavalable"
        }
        
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UITableViewCell
        let indexPath = homeTableView.indexPath(for: cell)!
        let restaurant = restaurantList[indexPath.row]
        
        let restaurantInfoViewController = segue.destination as! RestaurantInfoViewController
        restaurantInfoViewController.restaurant = restaurant
        
        homeTableView.deselectRow(at: indexPath, animated: true)
    }
    
}
