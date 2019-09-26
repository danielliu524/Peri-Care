//
//  TabBarController.swift
//  Pericare
//
//  Created by Daniel Liu on 12/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit
import CoreData
import Contacts

class TabBarController: UITabBarController {
    //synchronization manager keeps stores and views in sync
    lazy var manager: OCKSynchronizedStoreManager<OCKStore> = {
        //create a store
        let store = OCKStore(name: "PericareAppStore")
        //create a synchronization manager
        let manager = OCKSynchronizedStoreManager(wrapping: store)
//        //fill store up with data
//        manager.populateData()
        return manager
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let careViewController = CareViewController(storeManager: manager)
        let tasksTab = UINavigationController(rootViewController: careViewController)
        tasksTab.navigationBar.isHidden = false
        tasksTab.title = "Tasks"
//        let infoTab = UINavigationController(rootViewController: InfoTableViewController())
        let connectionViewController = ConnectionViewController(storeManager: manager)
        let connectionTab = UINavigationController(rootViewController: connectionViewController)
        connectionTab.title = "Connection"
        viewControllers = [tasksTab] + viewControllers! + [connectionTab]
        self.tabBar.items?[0].image = UIImage(systemName: "checkmark.square")
        self.tabBar.items?[3].image = UIImage(systemName: "person")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if UserDefaults.standard.bool(forKey: "hasScanned") {
//            return
//        }
//        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
//        if let scannerIntroViewController = storyboard.instantiateViewController(withIdentifier: "ScannerIntroViewController") as? ScannerIntroViewController {
//            present(scannerIntroViewController, animated: true, completion: nil)
//        }
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

////Add tasks here
//private extension OCKSynchronizedStoreManager where Store == OCKStore {
//    //add tasks into the store
//    func populateData() {
//        let thisMorning = Calendar.current.startOfDay(for: Date())
//        let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: thisMorning)!
//        let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: thisMorning)!
//        let afterLunch = Calendar.current.date(byAdding: .hour, value: 14, to: thisMorning)!
//        let beforeDinner = Calendar.current.date(byAdding: .hour, value: 20, to: thisMorning)!
//        //A schedule for anytime during the day
//        let medicationSchedule = OCKSchedule(composing: [OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1)), OCKScheduleElement(start: afterLunch, end: nil, interval: DateComponents(day: 1)), OCKScheduleElement(start: beforeDinner, end: nil, interval: DateComponents(day: 1))])
//        var medication = OCKTask(identifier: "medication", title: "Medication Times", carePlanID: nil, schedule: medicationSchedule)
//        medication.impactsAdherence = true
//
//        store.addTasks([medication])
//
//        let bowelSchedule = OCKSchedule(composing: [OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), text: "Tap \"Log\" when there is bowel movement", isAllDay: true)])
//        var bowel = OCKTask(identifier: "bowel", title: "Track bowel movement", carePlanID: nil, schedule: bowelSchedule)
//        bowel.impactsAdherence = false
//        store.addTasks([bowel])
//
//        let hydrationSchedule = OCKSchedule(composing: [OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true), OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true),OCKScheduleElement(start: thisMorning, end: nil, interval: DateComponents(day: 1), isAllDay: true)])
//        var hydration = OCKTask(identifier: "hydration", title: "Water Intake", carePlanID: nil, schedule: hydrationSchedule)
//        hydration.impactsAdherence = true
//        store.addTasks([hydration])
//        var contact1 = OCKContact(identifier: "doctor", givenName: "Doctor",
//                                  familyName: "Test", carePlanID: nil)
//        contact1.asset = "DoctorTest"
//        contact1.title = "Your Doctor"
//        contact1.role = "Test Description"
//        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "test")]
//        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "+852 96502827")]
//        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "+852 96502827")]
//
//        contact1.address = {
//            let address = OCKPostalAddress()
//            address.street = "Prince of Wales Hospital"
//            address.city = "Hong Kong"
//            return address
//        }()
//        store.addContacts([contact1])
//    }
//}
