//
//  ScannerConfirmViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CoreData
import CareKit
import Contacts

class ScannerConfirmViewController: UIViewController {
    lazy var manager: OCKSynchronizedStoreManager<OCKStore> = {
        //create a store
        let store = OCKStore(name: "PericareAppStore")
        //create a synchronization manager
        let manager = OCKSynchronizedStoreManager(wrapping: store)
        //fill store up with data
        return manager
    } ()
    var homeView: CareViewController!
    var tabView: TabBarController!
    var codeString: String!
    var operation: String!
    var date: Date!
    var hospital: String!
    var room: String!
    var steps: Int16!
    var smoker: Bool!
    var contentBundle: String!
    var user: UserMO!
    @IBOutlet var operationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var hospitalLabel: UILabel!
    @IBOutlet var roomLabel: UILabel!
    @IBAction func scanAgainPressed(withSender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmPressed(withSender: UIButton!) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            user = UserMO(context: appDelegate.persistentContainer.viewContext)
            user.operation = operation
            user.date = date
            user.hospital = hospital
            user.room = room
            user.steps = steps
            user.smoker = smoker
            user.content = contentBundle
            print("Saving user data")
            appDelegate.saveContext()
            if user.content == "contentBundle" {
                let info = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info.title = "What is colorectal cancer?"
                info.contentImages = ["1st GIF", "2nd GIF", "3rd GIF"] as NSObject
                info.contentText = [
                            "Colorectum (colon and rectum, the large bowel, or large intestine) is the last portion of the digestive system. It consists of the colon, the rectum and the anus.The water and nutrients of food are absorbed when they pass through the digestive system.",
                            "Cancer is a diverse group of diseases in which the body cells multiply out of control. These abnormal cells invade and spread to other parts of the body and cause damage. There are more than 100 types of cancers and each cancer has its own pattern of causation, behaviour and spread.",
                            "Most colorectal cancers begin as a small polyp. Polyps are usually benign, but some may gradually develop into cancer. The development of a polyp into cancer may take more than 10 years."
                    ] as NSObject
                info.contentTitles = ["", "", ""] as NSObject
                info.isCompleted = false
                info.order = "1"
                appDelegate.saveContext()
                let info2 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info2.title = "What operation am I having?"
                info2.contentImages = ["2nd GIF", "5th GIF", "1st GIF"] as NSObject
                info2.contentText = [
                            "A right hemicolectomy operation is to remove the right-hand portion of the colon. This will include the caecum, ascending colon and a portion of the transverse colon. It is necessary because of the way the blood supply supports the colon, rather than because the disease has spread.",
                            "Your surgeon will make three or four small cuts in your abdomen. They will put a telescope camera into one of these small cuts to show an enlarged image of the organs in your abdomen. The other cuts allow the surgeon to use special operating instruments.",
                            "Your surgeon will make one of the cuts longer so they can remove the bowel portion they have operated on. Sometimes it is not possible or safe to finish the operation by laparoscopic surgery. If so, your surgeon will change to an ‘open’ operation and make a larger incision to deal with this."
                    ] as NSObject
                info2.contentTitles = ["", "", ""] as NSObject
                info2.isCompleted = false
                info2.order = "11"
                appDelegate.saveContext()
                let info3 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info3.title = "Are there complications with this operation?"
                info3.contentImages = ["3rd GIF", "1st GIF"] as NSObject
                info3.contentText = [
                            "Risks of this operation are small and much less likely to affect you than the risk of doing nothing. However, this is a major operation and some people (less than 5% or fewer than 1 in 20) do not survive the surgery.",
                            "There are sometimes complications. These may include bleeding, infection, a leak from the anastomosis (the join where the bowel is connected back together), or injury to other organs within the abdomen",
                    ] as NSObject
                info3.contentTitles = ["", ""] as NSObject
                info3.isCompleted = false
                info3.order = "111"
                appDelegate.saveContext()
                let info4 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info4.title = "Will I need to have a stoma (bowel bag)?"
                info4.contentImages = ["2nd GIF", "3rd GIF"] as NSObject
                info4.contentText = [
                            "It is very unlikely that you will need a stoma. However, sometimes it is not possible to join the bowel back together again, so the end of the bowel is brought out onto the abdomen (tummy) to form an opening outside the body, known as a stoma.",
                            "The stoma may be permanent or temporary. If you need a stoma or it is possible that you may need a stoma, you will be seen by a stoma nurse. These specialist nurses are skilled in caring for patients who have a stoma and will be able to answer any questions you may have.",
                    ] as NSObject
                info4.contentTitles = ["", ""] as NSObject
                info4.isCompleted = false
                info4.order = "1111"
                appDelegate.saveContext()
                let info5 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info5.title = "What should I expect after surgery?"
                info5.contentImages = ["5th GIF", "1st GIF", "4th GIF"] as NSObject
                info5.contentText = [
                            "Immediately after the operation (within the first 24 to 48 hours), you will need oxygen through a face mask, a drip into a vein in one of your arms to give you fluid, and a catheter (tube) in your bladder to drain away urine",
                            "Later (the following day or so), you will need to start eating again, starting with liquids and gradually introducing solid foods, and move around as soon as possible",
                            "If you have laparoscopic surgery, you may recover more quickly after surgery and go home sooner. When you first start going to the toilet again, your faeces will be liquid. Sometimes it takes several weeks to get back to normal."
                    ] as NSObject
                info5.contentTitles = ["", "", ""] as NSObject
                info5.isCompleted = false
                info5.order = "11111"
                appDelegate.saveContext()
                let info6 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info6.title = "How long will I need to be in hospital?"
                info6.contentImages = ["2nd GIF", "5th GIF"] as NSObject
                info6.contentText = [
                            "You will stay in hospital for as little time as necessary, usually for between three and seven days. Your surgeon or specialist nurse will discuss with you daily achievements which you should try to meet. This programme is called ‘enhanced recovery after surgery’ (ERAS).",
                            "If, after you leave hospital, you have any new concerns or problems (for example, severe abdominal pain, a raised temperature or bleeding) it is important to contact your own doctor or the hospital. You will be given contact numbers when you leave hospital.",
                    ] as NSObject
                info6.contentTitles = ["", ""] as NSObject
                info6.isCompleted = false
                info6.order = "111111"
                appDelegate.saveContext()
                let info7 = InformationMO(context: appDelegate.persistentContainer.viewContext)
                info7.title = "What is the follow-up care like for my condition?"
                info7.contentImages = ["5th GIF", "1st GIF", "3rd GIF", "4th GIF", "2nd GIF"] as NSObject
                info7.contentText = [
                            "After treatment for colorectal cancer, follow-up care is important to help maintain good health. The most important reason for follow-up care, is to watch for signs of a cancer recurrence. Follow-up care is especially important in the first five years after treatment because this is when the risk of recurrence is highest.",
                            "A follow-up care plan may include regular physical examinations and other medical tests to monitor your recovery during the coming months and years. Many survivors feel worried or anxious that the cancer will come back after treatment.",
                            "The recommendations for follow-up care included in this section are mainly intended for people who had stage II or stage III colorectal cancer. It is less certain what testing should be done for people who had stage I colorectal cancer, because this stage is less likely to recur.",
                            "If you have had surgery for metastatic (cancer that has spread) colorectal cancer, it is important to talk with your doctor about a follow-up care plan specifically for you, since there is currently no standardized follow-up care schedule for this stage of colorectal cancer.",
                            "The recommended tests and schedule of testing are based on your risk of recurrence and your overall health. In general, you will visit your doctor and receive follow-up screening more often earlier in your recovery, because 95% of recurrences are found within five years."
                    ] as NSObject
                info7.contentTitles = ["", "", "", "", ""] as NSObject
                info7.isCompleted = false
                info7.order = "1111111"
                appDelegate.saveContext()

                let components = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: Date()), to: date)
                if components.day! == 0 {
                    homeView.navigationItem.title = "Operation Day"
                }
                if components.day! == 1 {
                    homeView.navigationItem.title = "\(components.day!) Day to Operation"
                }
                if components.day! > 1 {
                    homeView.navigationItem.title = "\(components.day!) Days to Operation"
                }
                if components.day! == -1 {
                    homeView.navigationItem.title = "\(components.day!) Day after Operation"
                }
                if components.day! < -1 {
                    homeView.navigationItem.title = "\(components.day!) Days after Operation"
                }
            }
            manager.populateData(operationDate: date)
        }
        UserDefaults.standard.set(true, forKey: "hasScanned")
//    self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        let alertController = UIAlertController(title: "Restart App", message: "Please restart the app", preferredStyle: .alert)
        present(alertController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        convertString(codeString: codeString)
    }
    
    func convertString(codeString: String) {
        var array: [String] = []
        var temp = ""
        for char in codeString {
            if char == "|" {
                array.append(temp)
                temp = ""
                continue
            }
            temp += String(char)
        }
        array.append(temp)
        operationLabel.text = array[0]
        hospitalLabel.text = array[1] + " " + array[2]
        roomLabel.text = array[3]
        dateLabel.text = array[4]
        operation = array[0]
        hospital = array[1] + " " + array[2]
        room = array[3]
        //date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        date = formatter.date(from: array[4])
        steps = Int16(array[5])
        if array[6] == "1" {
            smoker = true
        }
        else {
            smoker = false
        }
        contentBundle = array[7]
        print(operation!)
        print(hospital!)
        print(room!)
        print(date!)
        print(Calendar.current.startOfDay(for: Date()))
        print(steps!)
        print(smoker!)
//        let components = Calendar.current.dateComponents([.day], from: Date().addingTimeInterval(8.0*60*60), to: date)
        let components = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: Date()), to: date)
        print("Number of days: \(components.day!)")
        if components.day! == 0 {
            print("Operation Day")
        }
        if components.day! == 1 {
            print("\(components.day!) Day to Operation")
        }
        if components.day! > 1 {
            print("\(components.day!) Days to Operation")
        }
        if components.day! == -1 {
            print("\(components.day!) Day after Operation")
        }
        if components.day! < -1 {
            print("\(components.day!) Days after Operation")
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

private extension OCKSynchronizedStoreManager where Store == OCKStore {
    //add tasks into the store
    func populateData(operationDate: Date) {
        let operationDay = Calendar.current.startOfDay(for: operationDate)
        let preOpt = Calendar.current.date(byAdding: .day, value: -15, to: operationDay)!
        let withholdWarfarinDay = Calendar.current.date(byAdding: .day, value: -5, to: operationDay)!
        let dayBefore = Calendar.current.date(byAdding: .day, value: -1, to: operationDay)!
        let dayAfter = Calendar.current.date(byAdding: .day, value: 1, to: operationDay)!
        let dayAfter7am = Calendar.current.date(byAdding: .hour, value: 7, to: dayAfter)!
        let dayAfter8am = Calendar.current.date(byAdding: .hour, value: 8, to: dayAfter)!
        let dayAfter1pm = Calendar.current.date(byAdding: .hour, value: 6, to: dayAfter7am)!
        let dayAfter7pm = Calendar.current.date(byAdding: .hour, value: 6, to: dayAfter1pm)!
        let dayAfter8pm = Calendar.current.date(byAdding: .hour, value: 12, to: dayAfter8am)!
        let fourDaysAfter = Calendar.current.date(byAdding: .day, value: 4, to: operationDay)!
        let checkupDay = Calendar.current.date(byAdding: .day, value: 28, to: operationDay)!
        
        //MARK:warfarin(5 days before operation)
        let withholdWarfarinSchedule = OCKSchedule(composing: [OCKScheduleElement(start: withholdWarfarinDay, end: operationDay, interval: DateComponents(day: 1), isAllDay: true)])
        var withholdWarfarin = OCKTask(identifier: "withholdWarfarin", title: "Withhold Warfarin", carePlanID: nil, schedule: withholdWarfarinSchedule)
        withholdWarfarin.impactsAdherence = true
        store.addTasks([withholdWarfarin])
        
        //MARK:smoking(everyday if smoker)
        let smokingCessationSchedule = OCKSchedule(composing: [OCKScheduleElement(start: preOpt, end: nil, interval: DateComponents(day: 1), isAllDay: true)])
        var smokingCessation = OCKTask(identifier: "smokingCessation", title: "Did you smoke?", carePlanID: nil, schedule: smokingCessationSchedule)
        smokingCessation.impactsAdherence = false
        smokingCessation.instructions = "Smoking is bad for you! Tap \"Log\" everytime you smoke"
        store.addTasks([smokingCessation])
        
        //MARK:low residual diet(1 day before operation)
        let lowResidualDietSchedule = OCKSchedule(composing: [OCKScheduleElement(start: dayBefore, end: operationDay, interval: DateComponents(day: 1), isAllDay: true)])
        var lowResidualDiet = OCKTask(identifier: "lowResidualDiet", title: "Low Residual Diet Reminder", carePlanID: nil, schedule: lowResidualDietSchedule)
        lowResidualDiet.impactsAdherence = true
        lowResidualDiet.instructions = "Remember to have a low residual diet the day before your operation"
        store.addTasks([lowResidualDiet])
        
        //MARK:carbohydrate drink(4pm 10pm day before, 4am on day)
        let firstDrink = Calendar.current.date(byAdding: .hour, value: 16, to: dayBefore)!
        let secondDrink = Calendar.current.date(byAdding: .hour, value: 6, to: firstDrink)!
        let thirdDrink = Calendar.current.date(byAdding: .hour, value: 6, to: secondDrink)!
        let carbohydrateSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: firstDrink, end: operationDay,
                               interval: DateComponents(day: 1)),
            OCKScheduleElement(start: secondDrink, end: operationDay, interval: DateComponents(day:1)),
            OCKScheduleElement(start: thirdDrink, end: dayAfter, interval: DateComponents(day:1))
        ])
        var carbohydrate = OCKTask(identifier: "carbohydrate", title: "Take Carbohydrate Drink", carePlanID: nil, schedule: carbohydrateSchedule)
        carbohydrate.impactsAdherence = true
        store.addTasks([carbohydrate])
        
        //MARK:clear fluid(day of operation)
        let clearFluidSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: operationDay, end: dayAfter, interval: DateComponents(day: 1))
        ])
        var clearFluid = OCKTask(identifier: "clearFluid", title: "Clear fluid reminder", carePlanID: nil, schedule: clearFluidSchedule)
        clearFluid.instructions = "Clear fluids are allowed on the day of operation till 6:00 AM"
        clearFluid.impactsAdherence = true
        store.addTasks([clearFluid])
        
        //MARK:panadol post opt 3 days 7am 1pm 7pm
        let panadolSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter7am, end: fourDaysAfter, interval: DateComponents(day: 1)),
            OCKScheduleElement(start: dayAfter1pm, end: fourDaysAfter, interval: DateComponents(day: 1)),
            OCKScheduleElement(start: dayAfter7pm, end: fourDaysAfter, interval: DateComponents(day: 1))])
        var panadol = OCKTask(identifier: "panadol", title: "Take panadol", carePlanID: nil, schedule: panadolSchedule)
        panadol.impactsAdherence = true
        store.addTasks([panadol])
        
        //MARK:celecoxib post opt 3 days 8am 8pm
        let celecoxibSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter8am, end: fourDaysAfter, interval: DateComponents(day: 1)),
//
            OCKScheduleElement(start: dayAfter8pm, end: nil,
                               interval: DateComponents(day: 1))
        ])
        var celecoxib = OCKTask(identifier: "celecoxib", title: "Take celecoxib", carePlanID: nil, schedule: celecoxibSchedule)
        celecoxib.impactsAdherence = true
        store.addTasks([celecoxib])
        
        //MARK:hydration 8 times everyday postopt
        let hydrationSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
        ])
        var hydration = OCKTask(identifier: "hydration", title: "Drink 8 glasses of water", carePlanID: nil, schedule: hydrationSchedule)
        hydration.impactsAdherence = true
        store.addTasks([hydration])
        
        //MARK:spirometry 3 times everyday postopt
        let spirometrySchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true),
        ])
        var spirometry = OCKTask(identifier: "spirometry", title: "Spirometry", carePlanID: nil, schedule: spirometrySchedule)
        hydration.impactsAdherence = true
        store.addTasks([spirometry])
        
        //MARK:Bowel opening track everyday postopt
        let bowelSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true)
        ])
        var bowel = OCKTask(identifier: "bowel", title: "Track bowel opening", carePlanID: nil, schedule: bowelSchedule)
        bowel.impactsAdherence = false
        bowel.instructions = "Tap \"Log\" after bowel opening"
        store.addTasks([bowel])
        
        //MARK:Flatus everyday track postopt
        let flatusSchedule = OCKSchedule(composing: [
            OCKScheduleElement(start: dayAfter, end: nil, interval: DateComponents(day: 1), isAllDay: true)
        ])
        var flatus = OCKTask(identifier: "flatus", title: "Track flatus", carePlanID: nil, schedule: flatusSchedule)
        flatus.impactsAdherence = false
        flatus.instructions = "Tap \"Log\" after flatus"
        store.addTasks([flatus])
        
        //contacts
        var contact1 = OCKContact(identifier: "doctor", givenName: "Doctor",
                                  familyName: "Chan Tai Man", carePlanID: nil)
        contact1.asset = "DoctorChan"
        contact1.title = "Your Doctor"
        contact1.role = "Contact your doctor"
        contact1.emailAddresses = [OCKLabeledValue(label: CNLabelEmailiCloud, value: "test")]
        contact1.phoneNumbers = [OCKLabeledValue(label: CNLabelWork, value: "+852 96502827")]
        contact1.messagingNumbers = [OCKLabeledValue(label: CNLabelWork, value: "+852 96502827")]

        contact1.address = {
            let address = OCKPostalAddress()
            address.street = "Prince of Wales Hospital"
            address.city = "Hong Kong"
            return address
        }()
        store.addContacts([contact1])
    }
}

//        let thisMorning = Calendar.current.startOfDay(for: Date())
//        let aFewDaysAgo = Calendar.current.date(byAdding: .day, value: -4, to: thisMorning)!
//        let beforeBreakfast = Calendar.current.date(byAdding: .hour, value: 8, to: thisMorning)!
//        let afterLunch = Calendar.current.date(byAdding: .hour, value: 14, to: thisMorning)!
//        let beforeDinner = Calendar.current.date(byAdding: .hour, value: 20, to: thisMorning)!
        //A schedule for anytime during the day
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

