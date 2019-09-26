//
//  NewAchievementViewController.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit

class NewAchievementViewController: UIViewController {
    var recordsTable: RecordsTableViewController!
    var achievement: Achievement!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var medalImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBAction func dismissTapped(sender: UIButton) {
        recordsTable.tabBarController?.tabBar.isUserInteractionEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        medalImage.image = UIImage(named: achievement.image)
        nameLabel.text = achievement.name
        descriptionLabel.text = achievement.description
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
