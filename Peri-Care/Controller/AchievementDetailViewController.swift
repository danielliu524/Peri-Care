//
//  AchievementDetailViewController.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit

class AchievementDetailViewController: UIViewController {
    var recordsTable: RecordsTableViewController!
    @IBOutlet var achievementImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBAction func closeButtonTapped(sender: UIButton) {
        recordsTable.tabBarController?.tabBar.isUserInteractionEnabled = true
        dismiss(animated: true, completion: nil)
    }
    var achievement: Achievement!
    override func viewDidLoad() {
        super.viewDidLoad()
        achievementImage.image = UIImage(named: achievement.image)
        descriptionLabel.text = achievement.description
        nameLabel.text = achievement.name
        if achievement.isCompleted {
            statusLabel.text = "Completed!"
            achievementImage.alpha = 1.0
        }
        else {
            statusLabel.text = "Not yet completed"
            achievementImage.alpha = 0.3
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
