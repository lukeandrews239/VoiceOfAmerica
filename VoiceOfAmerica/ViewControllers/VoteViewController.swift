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

    weak var delegate: CoordinatorDelegate?

    weak var model: CandidateDelegate?

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
        // Try adding a new entry to the server! Prints the response in terminal
        // controlManager.addNewPrimaryEntry(entry: "Test") { reference in
        //     print(reference.debugDescription)
        // }
        layoutViews()
    }

    func vote(candidate: String) {
        delegate?.didVote(candidate: candidate)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.getNumCandidates() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInitialCell.identifier) else {
            fatalError("Cannot create cell, check tableView configuration")
        }
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

