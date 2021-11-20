//
//  SignUpViewController.swift
//  Food-Radar-App
//
//  Created by Brang Mai on 11/5/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var restrictionOtherField: UITextField!
    @IBOutlet weak var preferenceOtherField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user["name"] = nameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
          // other fields can be set just like with PFObject
        user["restrictOther"] = restrictionOtherField.text
        user["preferenceOther"] = preferenceOtherField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
            
        }
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
