//
//  InfoTableViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 9/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CoreData

class InfoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
//        var informations: [Information] = [
//        Information(title: "Item 1", isCompleted: false,
//                    contentTitles: ["Item 1 Step 1", "Item 1 Step 2", "Item 1 Step 3"],
//                    contentTexts: [
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
//            ], contentImages: ["sampleImage1", "sampleImage2", "sampleImage3"]),
//        Information(title: "Item 2", isCompleted: false,
//                    contentTitles: ["Item 2 Step 1", "Item 2 Step 2", "Item 2 Step 3"],
//                    contentTexts: [
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
//            ], contentImages: ["sampleImage1", "sampleImage2", "sampleImage3"]),
//        Information(title: "Item 3", isCompleted: false,
//                    contentTitles: ["Item 3 Step 1", "Item 3 Step 2", "Item 3 Step 3", "Item 3 Step 4"],
//                    contentTexts: [
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Random Random Random Random Random"
//            ], contentImages: ["sampleImage1", "sampleImage2", "sampleImage3", "sampleImage 3"]),
//        Information(title: "Item 4", isCompleted: false,
//                    contentTitles: ["Step 1", "Step 2"],
//                    contentTexts: [
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
//            ], contentImages: ["sampleImage1", "sampleImage2"]),
//        Information(title: "Item 5", isCompleted: false,
//                    contentTitles: ["Step 1", "Step 2", "Step 3"],
//                    contentTexts: [
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
//            ], contentImages: ["sampleImage1", "sampleImage2", "sampleImage3"])
//        ]
    struct GlobalInfo {
        static var informations: [InformationMO] = []
    }
    var fetchResultController: NSFetchedResultsController<InformationMO>!
    var infoDetailsViewController: InfoDetailsViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch data from datasource
        let fetchRequest: NSFetchRequest<InformationMO> = InformationMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    GlobalInfo.informations = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        ]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
//        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.tableFooterView = UIView()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//        navigationController?.navigationBar.shadowImage = nil
//        tabBarController?.tabBar.isHidden = false
//        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GlobalInfo.informations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as! InfoTableViewCell

        // Configure the cell...
        cell.infoLabel.text = GlobalInfo.informations[indexPath.row].title
        if !GlobalInfo.informations[indexPath.row].isCompleted {
//            cell.completedImageView.image = UIImage(named: "unchecked")
            cell.completedLabel.textColor = UIColor.red
            cell.completedLabel.text = "Tap to see more"
            cell.selectionStyle = .default
//            cell.backgroundColor = UIColor.red
        }
        else {
//            cell.completedImageView.image = UIImage(named: "checked")
            cell.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
            cell.completedLabel.text = "Completed!"
            cell.infoLabel.textColor = UIColor.white
            cell.completedLabel.textColor = UIColor.white
            cell.selectionStyle = .none
        }
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showInfoDetail" {
            infoDetailsViewController = segue.destination as? InfoDetailsViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                infoDetailsViewController?.pageHeadings = GlobalInfo.informations[indexPath.row].contentTitles as! [String]
                infoDetailsViewController?.pageImages = GlobalInfo.informations[indexPath.row].contentImages as! [String]
                infoDetailsViewController?.pageContent = GlobalInfo.informations[indexPath.row].contentText as! [String]
                infoDetailsViewController?.indexFromTable = indexPath.row
                infoDetailsViewController?.information = GlobalInfo.informations[indexPath.row]
                infoDetailsViewController?.infoTableViewController = self
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
    
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

extension UITableViewCell {
  func round(corners: UIRectCorner, withRadius radius: CGFloat) {
    let mask = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let shape = CAShapeLayer()
    shape.frame = self.bounds
    shape.path = mask.cgPath
    self.layer.mask = shape
  }
}
