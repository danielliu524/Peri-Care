//
//  InfoContentViewController.swift
//  Pericare
//
//  Created by Daniel Liu on 10/9/2019.
//  Copyright © 2019 Daniel Liu. All rights reserved.
//

import UIKit

class InfoContentViewController: UIViewController {
    @IBOutlet var infoImageView: UIImageView!
    @IBOutlet var infoHeading: UILabel! {
        didSet {
            infoHeading.numberOfLines = 0
        }
    }
    @IBOutlet var infoContent: UITextView!
    
    var index = 0
    var heading = ""
    var content = ""
    var imageFile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        infoImageView.loadGif(name: imageFile)
        infoHeading.text = heading
        infoContent.text = content
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
