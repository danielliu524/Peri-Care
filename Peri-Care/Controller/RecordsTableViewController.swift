//
//  RecordsTableViewController.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class RecordsTableViewController: UITableViewController {
    
    @IBOutlet var achievement1Btn: UIButton!
    @IBOutlet var achievement2Btn: UIButton!
    @IBOutlet var achievement3Btn: UIButton!
    @IBOutlet var achievement4Btn: UIButton!
    @IBOutlet var achievement5Btn: UIButton!
    @IBOutlet var achievement6Btn: UIButton!
    @IBOutlet var achievement7Btn: UIButton!
    @IBOutlet var achievement8Btn: UIButton!
    @IBOutlet var achievement9Btn: UIButton!
    @IBOutlet var achievement10Btn: UIButton!

    var newAchievement: Bool = true
    var achievements: [Achievement] = [
        Achievement(name: "Quitting for Good", isCompleted: true, description: "Stopped Smoking for a Week", image: "medal1"),
        Achievement(name: "Achievement2", isCompleted: false, description: "Description 2", image: "medal2"),
        Achievement(name: "Achievement3", isCompleted: false, description: "Description 3", image: "medal3"),
        Achievement(name: "Achievement4", isCompleted: false, description: "Description 4", image: "medal4"),
        Achievement(name: "Achievement5", isCompleted: false, description: "Description 5", image: "medal5"),
        Achievement(name: "Achievement6", isCompleted: false, description: "Description 6", image: "medal6"),
        Achievement(name: "Achievement7", isCompleted: false, description: "Description 7", image: "medal7"),
        Achievement(name: "Achievement8", isCompleted: false, description: "Description 8", image: "medal8"),
        Achievement(name: "Achievement9", isCompleted: false, description: "Description 9", image: "medal9"),
        Achievement(name: "Achievement10", isCompleted: false, description: "Description 10", image: "medal10")
    ]
    var sectionTitles = ["Records"]
    var sectionContent = [
                          [(image: "nutrition", text: "Nutrition & Hydration"),
                           (image: "bowel", text: "Bowel Opening & Flatus"),
                           (image: "activity", text: "Activity"),
                           (image: "medication", text: "Medication"),
                           (image: "pain", text: "Pain Level"),
                           (image: "wound", text: "Wound Diary")
        ]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.cellLayoutMarginsFollowReadableWidth = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView()
        if achievements[0].isCompleted {
            achievement1Btn.alpha = 1.0
        }
        else {
            achievement1Btn.alpha = 0.3
        }
        if achievements[1].isCompleted {
            achievement2Btn.alpha = 1.0
        }
        else {
            achievement2Btn.alpha = 0.3
        }
        if achievements[2].isCompleted {
            achievement3Btn.alpha = 1.0
        }
        else {
            achievement3Btn.alpha = 0.3
        }
        if achievements[3].isCompleted {
            achievement4Btn.alpha = 1.0
        }
        else {
            achievement4Btn.alpha = 0.3
        }
        if achievements[4].isCompleted {
            achievement5Btn.alpha = 1.0
        }
        else {
            achievement5Btn.alpha = 0.3
        }
        if achievements[5].isCompleted {
            achievement6Btn.alpha = 1.0
        }
        else {
            achievement6Btn.alpha = 0.3
        }
        if achievements[6].isCompleted {
            achievement7Btn.alpha = 1.0
        }
        else {
            achievement7Btn.alpha = 0.3
        }
        if achievements[7].isCompleted {
            achievement8Btn.alpha = 1.0
        }
        else {
            achievement8Btn.alpha = 0.3
        }
        if achievements[8].isCompleted {
            achievement9Btn.alpha = 1.0
        }
        else {
            achievement9Btn.alpha = 0.3
        }
        if achievements[9].isCompleted {
            achievement10Btn.alpha = 1.0
        }
        else {
            achievement10Btn.alpha = 0.3
        }
        if newAchievement {
            self.performSegue(withIdentifier: "newAchievement", sender: nil)
            newAchievement = false
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsCell", for: indexPath) as! RecordsTableViewCell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.titleView.text = cellData.text
            cell.iconView.image = UIImage(named: cellData.image)
            cell.detailLabel.text = "Cups of water drank: 8"
            cell.detailLabel.textColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsCell", for: indexPath) as! RecordsTableViewCell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.titleView.text = cellData.text
            cell.iconView.image = UIImage(named: cellData.image)
            cell.detailLabel.text = "1 time today"
            cell.detailLabel.textColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsCell", for: indexPath) as! RecordsTableViewCell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.titleView.text = cellData.text
            cell.iconView.image = UIImage(named: cellData.image)
            cell.detailLabel.text = "2500/5000 Steps"
            cell.detailLabel.textColor = UIColor.red
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsCell", for: indexPath) as! RecordsTableViewCell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.titleView.text = cellData.text
            cell.iconView.image = UIImage(named: cellData.image)
            cell.detailLabel.text = "Next medication time: 8:00 PM"
            cell.detailLabel.textColor = UIColor.red
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordsCell", for: indexPath) as! RecordsTableViewCell
            let cellData = sectionContent[indexPath.section][indexPath.row]
            cell.titleView.text = cellData.text
            cell.iconView.image = UIImage(named: cellData.image)
            cell.detailLabel.text = "Last logged: 🙁"
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WoundCell", for: indexPath) as! RecordsWoundCell
            cell.titleView.text = "Wound Diary"
            cell.iconView.image = UIImage(named: "wound")
            cell.recordsTableViewController = self
//            cell.woundImage.image = UIImage(named: "woundImage")
            return cell
        default:
            fatalError("Failed to instantiate table view")
        }
    }
    
    lazy var manager: OCKSynchronizedStoreManager<OCKStore> = {
        let store = OCKStore(name: "PericareAppStore")
        //create a synchronization manager
        let manager = OCKSynchronizedStoreManager(wrapping: store)
        return manager
    } ()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = RecordsNutritionViewController(storeManager: manager)
            viewController.recordsTableViewController = self
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
        case 1:
            let viewController = RecordsBowelViewController(storeManager: manager)
            viewController.recordsTableViewController = self
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
        case 2:
            let viewController = RecordsActivityViewController(storeManager: manager)
            viewController.recordsTableViewController = self
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
        case 3:
            let viewController = RecordsMedicationViewController(storeManager: manager)
            viewController.recordsTableViewController = self
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
        case 4:
            let viewController = RecordsPainViewController(storeManager: manager)
            viewController.recordsTableViewController = self
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true, completion: nil)
//        case 5:
//            let viewController = RecordsWoundsViewController()
//            viewController.recordsTableViewController = self
//            let navigationController = UINavigationController(rootViewController: viewController)
//            present(navigationController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionContent[section].count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "achievement1" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[0]
        }
        if segue.identifier == "achievement2" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[1]
        }
        if segue.identifier == "achievement3" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[2]
        }
        if segue.identifier == "achievement4" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[3]
        }
        if segue.identifier == "achievement5" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[4]
        }
        if segue.identifier == "achievement6" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[5]
        }
        if segue.identifier == "achievement7" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[6]
        }
        if segue.identifier == "achievement8" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[7]
        }
        if segue.identifier == "achievement9" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[8]
        }
        if segue.identifier == "achievement10" {
            tabBarController?.tabBar.isUserInteractionEnabled = false
            let achievementsDetailViewController = segue.destination as! AchievementDetailViewController
            achievementsDetailViewController.recordsTable = self
            achievementsDetailViewController.achievement = achievements[9]
        }
        if segue.identifier == "newAchievement" {
            let newAchievementViewController = segue.destination as! NewAchievementViewController
            newAchievementViewController.recordsTable = self
            newAchievementViewController.achievement = achievements[0]
        }
        if segue.identifier == "presentWoundDiary" {
            let recordsWoundsNavigationController = segue.destination as! UINavigationController
            let recordsWoundsViewController = recordsWoundsNavigationController.children[0] as! RecordsWoundsTableViewController
            recordsWoundsViewController.recordsTableViewController = self
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
