//
//  RecordsNutrition.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class RecordsNutritionViewController: OCKDailyPageViewController<OCKStore> {
    var recordsTableViewController: RecordsTableViewController!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recordsTableViewController.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Nutrition & Hydration"
    }
    
    override func dailyPageViewController<S>(_ dailyPageViewController: OCKDailyPageViewController<S>, prepare listViewController: OCKListViewController, for date: Date) where S : OCKStoreProtocol {
        let smokeCessationDataSeries = OCKDataSeriesConfiguration<OCKStore>(taskIdentifier: "smokingCessation", legendTitle: "No. of Times", gradientStartColor: UIColor.blue, gradientEndColor: UIColor.systemBlue, markerSize: 10, eventAggregator: OCKEventAggregator.countOutcomeValues)
        let smokeCessationChart = OCKCartesianChartViewController(storeManager: self.storeManager, type: .bar, dataSeriesConfigurations: [smokeCessationDataSeries], date: date)
        smokeCessationChart.synchronizedView.headerView.titleLabel.text = "Smoking"
        smokeCessationChart.synchronizedView.headerView.detailLabel.text = "This Week"
        listViewController.appendViewController(smokeCessationChart, animated: true)
    }
}
