//
//  ViewController.swift
//  Food-Radar-App
//
//  Created by Alicia Isler on 12/3/21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    let contentView = UIHostingController(rootView: ContentView())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        // Do any additional setup after loading the view.
        view.addSubview(contentView.view)
        setupConstraints()
    }
    
    fileprivate func setupConstraints(){
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
