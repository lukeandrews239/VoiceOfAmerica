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

    var candidates = [Candidate]()

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
        layoutViews()
    }

    @objc func vote(candidate: String) {
        delegate?.didVote(candidate: candidate)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInitialCell.identifier) as! CandidateInitialCell
        cell.nameText = candidates[indexPath.row].getName()
        cell.bioText = candidates[indexPath.row].bio
        // do some shit to it
        return cell
    }

    func layoutViews() {
        // Hierarchy
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CandidateInitialCell.self, forCellReuseIdentifier: CandidateInitialCell.identifier)
        view.addSubview(tableView)

        // Style
        let safeAreaGuide = view.safeAreaLayoutGuide

        // Layout
        tableView.edgeAnchors == safeAreaGuide.edgeAnchors

    }

    func refreshData() {
        if let newCandidates = model?.getCandidates() {
                self.candidates = newCandidates
                tableView.reloadData()
        }
        tableView.reloadData()
    }
}

