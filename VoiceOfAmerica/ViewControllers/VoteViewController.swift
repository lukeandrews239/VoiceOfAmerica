//
//  VoteViewController.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/9/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {

    var controlManager: ControlManager = ControlManager.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "VOICE OF AMERICA"
        // Sample red color to demonstrate architecture completeness
        self.view.backgroundColor = UIColor.red
        // Try adding a new entry to the server! Prints the response in terminal
        controlManager.addNewPrimaryEntry(entry: "Test") { reference in
            print(reference)
        }
    }


}

