//
//  PollDataViewController.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/22/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation
import UIKit
import Anchorage
import BonMot

class PollDataViewController: UIViewController {

    weak var model: CandidateDelegate?

    weak var delegate: CoordinatorDelegate?

    private var candidates = [Candidate]()

    let tableView: UITableView = {
        let table = UITableView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CandidateInitialCell.self, forCellReuseIdentifier: CandidateInitialCell.identifier)
        view.backgroundColor = UIColor.white
        // Style
        let safeAreaGuide = view.safeAreaLayoutGuide

        print(self.candidates)
        // Layout
        view.addSubview(tableView)
        tableView.edgeAnchors == safeAreaGuide.edgeAnchors
    }
    private var controlManager: ControlManager = ControlManager.shared()

    // Method to allow dependency injection by coordinator
    func recieveDataAndReload(candidateList: [Candidate]) {
        self.candidates = candidateList
        // Reload the tableview
        self.tableView.reloadData()
    }
}

extension PollDataViewController: UITableViewDelegate, UITableViewDataSource {

    // Placeholders to compile
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInitialCell.identifier) as! CandidateInitialCell
        cell.nameText = candidates[indexPath.row].getName()
        cell.bioText = "Votes: " + String(candidates[indexPath.row].getVote())
        return cell
    }

}
