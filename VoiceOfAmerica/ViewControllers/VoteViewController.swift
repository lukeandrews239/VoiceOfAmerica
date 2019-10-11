//
//  VoteViewController.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/9/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit
import Anchorage

class VoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Instance of model.
    // We could also use delegate pattern to link these together. Could be good.
    let candidateModel = CandidateModel()

    var candidateCell = UITableViewCell()

    let tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    var controlManager: ControlManager = ControlManager.shared()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "VOICE OF AMERICA"
        // Sample red color to demonstrate architecture completeness
        self.view.backgroundColor = UIColor.white
        // Test request success
        controlManager.getCurrentStateValues { (response: NSDictionary?) in
            if let packet = response {
                print("Server response: ")
                print(packet)
            } else {
                print("Failure")
            }
        }
        layoutViews()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidateModel.candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = candidateCell
        // do some shit to it
        return cell
    }


    func layoutViews() {
        // Hierarchy
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        // Style
        let safeAreaGuide = view.safeAreaLayoutGuide

        // Layout
        tableView.edgeAnchors == safeAreaGuide.edgeAnchors

    }
}

