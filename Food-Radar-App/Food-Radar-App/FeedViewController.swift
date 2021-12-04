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
    struct result: Codable {
        let restaurant_name: String
        let restaurant_phone: String
        let restaurant_website: String
        let hours: String
        let price_range: String
        let restaurant_id: Double
        let address: Address
    }
    
    struct Address: Codable {
        let city: String
        let state: String
        let postal_code: String
        let street: String
        let formatted: String
    }
    
    var restaurantList = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTableView.dataSource = self
        homeTableView.delegate = self

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.documenu.com/v2/restaurant/4072702673999819?key=272dbbb2dd1f1609ae7c84a8a42f6d58")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 self.restaurantList = dataDictionary["result"] as! [[String: Any]]

                 self.homeTableView.reloadData()
             }
        }
        task.resume()
    }
    
    @IBAction func searchButton(_ sender: Any) {
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
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "FeedViewCell") as! FeedViewCell
        let restaurant = restaurantList[indexPath.row]
        let restaurant_name = restaurant["restaurant_name"] as! String
        let price_range = restaurant["price_range"] as! String
        let hours = restaurant["hours"] as! String
        let phone = restaurant["phone"] as! String
        
        cell.restaurantName!.text = restaurant_name
        cell.priceRange!.text = price_range
        cell.hours!.text = hours
        cell.phone!.text = phone
        
//        let baseUrl = "https://image.tmdb.org/t/p/w500"
//        let posterPath = movie["poster_path"] as! String
//        let posterUrl = URL(string: baseUrl + posterPath)
//
//        cell.posterView.af_setImage(withURL: posterUrl!)
//
        return cell
    }
    
//    func homeTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//    }
//
//    func homeTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = homeTableView.dequeueReusableCell(withIdentifier: "FeedViewCell") as! FeedViewCell
//        let restaurant = restaurantList[indexPath.row]
//        let restaurant_name = restaurant["restaurant_name"] as! String
//        let price_range = restaurant["price_range"] as! String
//        let hours = restaurant["hours"] as! String
//        let phone = restaurant["phone"] as! String
//
//        cell.restaurantName!.text = restaurant_name
//        cell.priceRange!.text = price_range
//        cell.hours!.text = hours
//        cell.phone!.text = phone
//
////        let baseUrl = "https://image.tmdb.org/t/p/w500"
////        let posterPath = movie["poster_path"] as! String
////        let posterUrl = URL(string: baseUrl + posterPath)
////
////        cell.posterView.af_setImage(withURL: posterUrl!)
////
//        return cell
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
