//
//  RecordsBowelViewController.swift
//  Peri-Care
//
//  Created by Daniel Liu on 15/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class RecordsBowelViewController: OCKDailyPageViewController<OCKStore> {
    var recordsTableViewController: RecordsTableViewController!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        recordsTableViewController.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Bowel Opening & Flatus"
    }
    
    override func dailyPageViewController<S>(_ dailyPageViewController: OCKDailyPageViewController<S>, prepare listViewController: OCKListViewController, for date: Date) where S : OCKStoreProtocol {
//        let bowelDataSeries = OCKDataSeriesConfiguration<OCKStore>(taskIdentifier: "bowel", legendTitle: "Number of Times", gradientStartColor: UIColor.blue, gradientEndColor: UIColor.systemBlue, markerSize: 10, eventAggregator: OCKEventAggregator.countOutcomeValues)
//        let bowelChart = OCKCartesianChartViewController(storeManager: self.storeManager, type: .bar, dataSeriesConfigurations: [bowelDataSeries], date: date)
//        bowelChart.synchronizedView.headerView.titleLabel.text = "Bowel Movement"
//        bowelChart.synchronizedView.headerView.detailLabel.text = "This Week"
//        listViewController.appendViewController(bowelChart, animated: true)
    }
}
