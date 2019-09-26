//
//  PhotoView.swift
//  Peri-Care
//
//  Created by Daniel Liu on 12/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class PhotoView: OCKView, OCKCardable {
    
    var cardView: UIView {self}
    
    var contentView: UIView = OCKView()
    
    let headerView = OCKHeaderView {
        $0.showsSeparator = true
        $0.showsDetailDisclosure = false
    }
    
    let photoView = UIImageView()

    override init() {
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        headerView.detailLabel.textColor = .secondaryLabel
        headerView.titleLabel.text = "Wound Diary"
        headerView.detailLabel.text = "Upload a photo of your wound"
        
        photoView.image = UIImage(named: "photo")
        photoView.contentMode = .scaleAspectFit
        photoView.clipsToBounds = true
        
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds

        addSubview(contentView)
        contentView.addSubview(photoView)
        contentView.addSubview(headerView)

        photoView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
//            photoView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 0),
//            photoView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: 0),
//            photoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
//            photoView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            photoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    override func styleDidChange() {
        super.styleDidChange()
        let cachedStyle = style()
        enableCardStyling(true, style: cachedStyle)
        directionalLayoutMargins = cachedStyle.dimension.directionalInsets1
    }
}
