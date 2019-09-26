//
//  InfoDetailsViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CoreData

class InfoDetailsViewController: UIViewController, InfoPageViewControllerDelegate {
    var indexFromTable: Int!
    @IBOutlet var pageView: UIView!
    @IBOutlet var pageController: UIPageControl!
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    var information: InformationMO!
    var infoTableViewController: InfoTableViewController!
    @IBAction func nextButtonTapped(sender: UIButton!) {
        if let index = pageViewController?.currentIndex {
            switch index {
            case 0...(pageHeadings.count-2):
                pageViewController?.forwardPage()
            case pageHeadings.count-1:
                InfoTableViewController.GlobalInfo.informations[indexFromTable].isCompleted = true
//                information.isCompleted = true
//                information.setValue(true, forKey: "isCompleted")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Information")

                fetchRequest.predicate = NSPredicate(format: "isCompleted = true")

                do {
                    let results = try context.fetch(fetchRequest) as? [NSManagedObject]
                    if results?.count != 0 { // Atleast one was returned

                        // In my case, I only updated the first item in results
                        results?[0].setValue(true, forKey: "isCompleted")
                    }
                } catch {
                    print("Fetch Failed: \(error)")
                }
                do {
                    try context.save()
                   }
                catch {
                    print("Saving Core Data Failed: \(error)")
                }
                infoTableViewController.tableView.reloadData()
                self.dismiss(animated: true, completion: nil)
//                navigationController?.popViewController(animated: true)
            default:
                break
            }
        }
        updateUI()
    }
    var pageViewController: InfoPageViewController?
    var pageImages: [String] = ["sampleImage1", "sampleImage2", "sampleImage3", "sampleImage1"]
    var pageHeadings: [String] = ["Step 1", "Step 2", "Step 3", "Step 4"]
    var pageContent: [String] = ["Text1", "Text2", "Text3", "Text4"]
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.prefersLargeTitles = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        tabBarController?.tabBar.isHidden = true
        pageController.numberOfPages = pageHeadings.count
//        contentView.pageImages = pageImages
//        contentView.pageHeadings = pageHeadings
//        contentView.pageContent = pageContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        infoTableViewController.tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContent" {
            pageViewController = segue.destination as? InfoPageViewController
            pageViewController?.infoDelegate = self
            pageViewController?.pageContent = pageContent
            pageViewController?.pageHeadings = pageHeadings
            pageViewController?.pageImages = pageImages
        }
    }
    
    func updateUI() {
        if let index = pageViewController?.currentIndex {
            switch index {
            case 0...(pageHeadings.count-2):
                nextButton.setTitle("Next", for: .normal)
            case pageHeadings.count-1:
                nextButton.setTitle("Done", for: .normal)
            default:
                break
            }
            pageController.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
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
