//
//  RingView.swift
//  Peri-Care
//
//  Created by Daniel Liu on 12/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class RingView: OCKView, OCKCardable {
    
    var cardView: UIView {self}
    
    var contentView: UIView = OCKView()
    
    let headerView = OCKHeaderView {
        $0.showsSeparator = true
        $0.showsDetailDisclosure = false
    }
    
    let ringView = OCKCompletionRingView()
    
    let textView = UILabel()

    var goal: Double!
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        headerView.detailLabel.textColor = .secondaryLabel

        ringView.lineWidth = 15
        
        textView.font = UIFont.boldSystemFont(ofSize: 20.0)
        textView.textAlignment = .center

        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds

        addSubview(contentView)
        contentView.addSubview(textView)
        contentView.addSubview(ringView)
        contentView.addSubview(headerView)

        textView.translatesAutoresizingMaskIntoConstraints = false
        ringView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),

            ringView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            ringView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ringView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ringView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -20),
             ringView.heightAnchor.constraint(equalToConstant: 200),

            textView.topAnchor.constraint(equalTo: ringView.bottomAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    override func styleDidChange() {
        super.styleDidChange()
        let cachedStyle = style()
        enableCardStyling(true, style: cachedStyle)
        directionalLayoutMargins = cachedStyle.dimension.directionalInsets1
    }

}
