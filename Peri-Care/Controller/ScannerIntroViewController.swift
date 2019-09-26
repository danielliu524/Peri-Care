//
//  ScannerIntroViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit

class ScannerIntroViewController: UIViewController {
    var homeView: CareViewController!
    var tabView: TabBarController!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //true = cannot dismiss, false = can
        self.isModalInPresentation = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scan" {
            let destination = segue.destination as! ScannerViewController
            destination.homeView = homeView
            destination.tabView = tabView
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
