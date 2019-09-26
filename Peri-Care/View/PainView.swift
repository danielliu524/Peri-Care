//
//  PainView.swift
//  Peri-Care
//
//  Created by Daniel Liu on 13/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit
import CareKit

class PainView: OCKView, OCKCardable {

    @IBAction func sliderChanged(sender: UISlider) {
        textView.text = String(Int(ratingView.value*10)) + "/10"
        switch ratingView.value {
        case 0...0.1:
            emojiView.text = "😁"
        case 0.1...0.3:
            emojiView.text = "🙂"
        case 0.3...0.6:
            emojiView.text = "😐"
        case 0.6...0.9:
            emojiView.text = "🙁"
        case 0.9...1.0:
            emojiView.text = "😫"
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        if logButton.titleLabel?.text == "Confirm" {
            logButton.setTitle("Completed", for: .normal)
            logButton.backgroundColor = style().color.systemGray5
            logButton.setTitleColor(style().color.systemBlue, for: .normal)
            ratingView.isUserInteractionEnabled = false
        }
        else {
            logButton.setTitle("Confirm", for: .normal)
            logButton.backgroundColor = style().color.systemBlue
            logButton.setTitleColor(style().color.white, for: .normal)
            ratingView.isUserInteractionEnabled = true
        }
    }

    var cardView: UIView {self}

    var contentView: UIView = OCKView()

    let headerView = OCKHeaderView {
        $0.showsSeparator = true
        $0.showsDetailDisclosure = false
    }

    let ratingView = UISlider()
    
    let emojiView = UILabel()

    let textView = UILabel()
    
    let logButton = UIButton()

    override init() {
        super.init()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        headerView.detailLabel.textColor = .secondaryLabel
        headerView.titleLabel.text = "Rate your pain"
        headerView.detailLabel.text = "Adjust the slider based on your pain from 0 to 10"

        ratingView.value = 0.5
        ratingView.addTarget(self, action: #selector(PainView.sliderChanged(sender:)), for: .valueChanged)

        textView.font = UIFont.boldSystemFont(ofSize: 20.0)
        textView.textAlignment = .center
        textView.text = String(Int(ratingView.value*10)) + "/10"

        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        
        logButton.setTitle("Confirm", for: .normal)
        logButton.setTitleColor(UIColor.white, for: .normal)
        logButton.backgroundColor = style().color.systemBlue
        logButton.layer.cornerRadius = 10.0
        logButton.layer.masksToBounds = true
        logButton.addTarget(self, action: #selector(PainView.buttonPressed(sender:)), for: .touchUpInside)
        
        emojiView.text = "😐"
        emojiView.textAlignment = .center
        emojiView.font = UIFont.systemFont(ofSize: 50.0)

        addSubview(contentView)
        contentView.addSubview(logButton)
        contentView.addSubview(textView)
        contentView.addSubview(ratingView)
        contentView.addSubview(emojiView)
        contentView.addSubview(headerView)

        logButton.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            
            emojiView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            emojiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            emojiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            emojiView.bottomAnchor.constraint(equalTo: ratingView.topAnchor, constant: -10),

            ratingView.topAnchor.constraint(equalTo: emojiView.bottomAnchor, constant: 20),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -20),

            textView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 0),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textView.bottomAnchor.constraint(equalTo: logButton.topAnchor, constant: -20),

            logButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0),
            logButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            logButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            logButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            logButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }

    override func styleDidChange() {
        super.styleDidChange()
        let cachedStyle = style()
        enableCardStyling(true, style: cachedStyle)
        directionalLayoutMargins = cachedStyle.dimension.directionalInsets1
    }
}
