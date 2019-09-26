//
//  RecordsMedicationViewController.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class RecordsMedicationViewController: OCKDailyPageViewController<OCKStore> {
    var recordsTableViewController: RecordsTableViewController!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recordsTableViewController.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Medication"
    }
    
    override func dailyPageViewController<S>(_ dailyPageViewController: OCKDailyPageViewController<S>, prepare listViewController: OCKListViewController, for date: Date) where S : OCKStoreProtocol {
        let medicationDataSeries = OCKDataSeriesConfiguration<OCKStore>(taskIdentifier: "panadol", legendTitle: "Panadol Taken", gradientStartColor: UIColor.blue, gradientEndColor: UIColor.systemBlue, markerSize: 10, eventAggregator: OCKEventAggregator.countOutcomeValues)
        let medicationChart = OCKCartesianChartViewController(storeManager: self.storeManager, type: .bar, dataSeriesConfigurations: [medicationDataSeries], date: date)
        medicationChart.synchronizedView.headerView.titleLabel.text = "Panadol Intake"
        medicationChart.synchronizedView.headerView.detailLabel.text = "This Week"
        listViewController.appendViewController(medicationChart, animated: true)
    }
}
