//
//  CareViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 12/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import Foundation
import UIKit
import CareKit
import HealthKit
import CoreData

class CareViewController: OCKDailyPageViewController<OCKStore>,  UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    var fetchResultController: NSFetchedResultsController<UserMO>!
    var photoCard: PhotoView!
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action ) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        let photoLibraryAction = UIAlertAction(title: "Photos", style: .default, handler: {(action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        photoSourceRequestController.addAction(cameraAction)
        photoSourceRequestController.addAction(photoLibraryAction)
        photoSourceRequestController.addAction(cancelAction)
        present(photoSourceRequestController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Running")
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("run")
            photoCard.photoView.image = selectedImage
            photoCard.photoView.contentMode = .scaleAspectFill
            photoCard.photoView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
    var healthStore: HKHealthStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        ]
//        navigationItem.title = "99 Days after Operation"
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            let allTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)])
            healthStore.requestAuthorization(toShare: allTypes as? Set<HKSampleType>, read: allTypes as? Set<HKObjectType>) {success, error in
                if !success {
                    print("user denied health data")
                }
            }
        }
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Connection", style: .plain, target: self, action: #selector(presentContactsListViewController))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserDefaults.standard.bool(forKey: "hasScanned") {
            return
        }
        let fetchRequest: NSFetchRequest<UserMO> = UserMO.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "operation", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
                fetchResultController.delegate = self
                do {
                    try fetchResultController.performFetch()
                    if let fetchedObjects = fetchResultController.fetchedObjects {
                        guard let operationDate = fetchedObjects[0].date else {
                            navigationItem.title = ""
                            return
                        }
                        let components = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: Date()), to: operationDate)
                        if components.day! == 0 {
                            navigationItem.title = "Operation Day"
                        }
                        if components.day! == 1 {
                            navigationItem.title = "\(components.day!) Day to Operation"
                        }
                        if components.day! > 1 {
                            navigationItem.title = "\(components.day!) Days to Operation"
                        }
                        if components.day! == -1 {
                            navigationItem.title = "\(components.day!) Day after Operation"
                        }
                        if components.day! < -1 {
                            navigationItem.title = "\(components.day!) Days after Operation"
                        }
                    }
                } catch {
                    print(error)
                }
            }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "hasScanned") {
            return
        }
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let scannerIntroViewController = storyboard.instantiateViewController(withIdentifier: "ScannerIntroViewController") as? ScannerIntroViewController {
            scannerIntroViewController.homeView = self
            scannerIntroViewController.tabView = self.tabBarController as? TabBarController
            present(scannerIntroViewController, animated: true, completion: nil)
        }
    }
    
    //Called when selected date changes
    override func dailyPageViewController<S>(_ dailyPageViewController: OCKDailyPageViewController<S>, prepare listViewController: OCKListViewController, for date: Date) where S : OCKStoreProtocol {
        let identifiers = ["withholdWarfarin", "smokingCessation", "lowResidualDiet", "carbohydrate", "panadol", "celecoxib", "clearFluid", "hydration", "spirometry", "bowel", "flatus"]
        let anchor = OCKTaskAnchor.taskIdentifiers(identifiers)
        var query = OCKTaskQuery(for: date)
        query.excludesTasksWithNoEvents = true
        storeManager.store.fetchTasks(anchor, query: query) {result in
            switch result {
                case .failure(let error): print("Error: \(error)")
                case .success(let tasks):
                    //MARK:Warfarin
                    if let warfarinTask = tasks.first(where: { $0.identifier == "withholdWarfarin"}) {
                            let warfarinCard = OCKSimpleTaskViewController(
                                storeManager: self.storeManager,
                                task: warfarinTask,
                                eventQuery: OCKEventQuery(for: date))
                            listViewController.appendViewController(warfarinCard, animated: false)
                    }
            
                    //MARK:Smoke
                    if let smokeTask = tasks.first(where: { $0.identifier == "smokingCessation"}) {
                        let smokeCard = OCKButtonLogTaskViewController(
                            storeManager: self.storeManager,
                            task: smokeTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(smokeCard, animated: false)
                    }
            
                    //MARK:Diet
                    if let dietTask = tasks.first(where: { $0.identifier == "lowResidualDiet"}) {
                        let dietCard = OCKInstructionsTaskViewController(
                            storeManager: self.storeManager,
                            task: dietTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(dietCard, animated: false)
                    }
                       
                    //MARK:Carbohydrate
                    if let carbohydrateTask = tasks.first(where: { $0.identifier == "carbohydrate" }) {
                        let carbohydrateCard = OCKChecklistTaskViewController(
                            storeManager: self.storeManager,
                            task: carbohydrateTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(carbohydrateCard, animated: false)
                    }
            
                    //MARK:panadol
                    if let panadolTask = tasks.first(where: { $0.identifier == "panadol" }) {
                        let panadolCard = OCKChecklistTaskViewController(
                            storeManager: self.storeManager,
                            task: panadolTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(panadolCard, animated: false)
                    }
            
                    //MARK:celecoxib
                    if let celecoxibTask = tasks.first(where: { $0.identifier == "celecoxib" }) {
                        let celecoxibCard = OCKChecklistTaskViewController(
                            storeManager: self.storeManager,
                            task: celecoxibTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(celecoxibCard, animated: false)
                    }
                    
                    //MARK:clearfluid
                    if let clearFluidTask = tasks.first(where: { $0.identifier == "clearFluid" }) {
                        let clearFluidCard = OCKInstructionsTaskViewController(
                            storeManager: self.storeManager,
                            task: clearFluidTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(clearFluidCard, animated: false)
                    }
                    
                    //MARK:Spirometry
                    if let spirometryTask = tasks.first(where: { $0.identifier == "spirometry" }) {
                        let spirometryCard = OCKGridTaskViewController(
                            storeManager: self.storeManager,
                            task: spirometryTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(spirometryCard, animated: false)
                    }
                    
                    //MARK:hydration
                    if let hydrationTask = tasks.first(where: { $0.identifier == "hydration" }) {
                        let hydrationCard = OCKGridTaskViewController(
                            storeManager: self.storeManager,
                            task: hydrationTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(hydrationCard, animated: false)
                    }
                    
                    //MARK:bowel
                    if let bowelTask = tasks.first(where: { $0.identifier == "bowel" }) {
                        let bowelCard = OCKButtonLogTaskViewController(
                            storeManager: self.storeManager,
                            task: bowelTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(bowelCard, animated: false)
                    }
                    
                    //MARK:flatus
                    if let flatusTask = tasks.first(where: { $0.identifier == "flatus" }) {
                        let flatusCard = OCKButtonLogTaskViewController(
                            storeManager: self.storeManager,
                            task: flatusTask,
                            eventQuery: OCKEventQuery(for: date))
                        listViewController.appendViewController(flatusCard, animated: false)
                    }
            
                    let activityCard = RingView()
                    activityCard.headerView.titleLabel.text = "Activity"
                    activityCard.headerView.detailLabel.text = "DetailText"
                    activityCard.goal = 5000.0
                    let steps = 2112.0
                    activityCard.ringView.setProgress(CGFloat(steps/activityCard.goal))
                    activityCard.textView.text = String(Int(steps)) + "/" + String(Int(activityCard.goal)) + " Steps"
                    listViewController.appendView(activityCard, animated: false)
                    listViewController.appendView(UIView(), animated: false)
            }
        }
    }
    
    func getTodaysSteps(completion: @escaping (Double) -> Void) {
        
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("Failed to fetch steps rate")
                completion(resultCount)
                return
            }
            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }
            
            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(query)
    }
}
