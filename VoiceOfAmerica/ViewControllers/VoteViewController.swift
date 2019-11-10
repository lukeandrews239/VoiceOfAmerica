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
        self.view.backgroundColor = UIColor.white
        // Test vote for a candidate
        controlManager.voteForCandidate(candidate: "Joe Walsh") { response in
            print(response ?? "Response failed")
        }
        layoutViews()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInitialCell.identifier) as! CandidateInitialCell
        cell.nameText = candidates[indexPath.row].getName()
        cell.bioText = candidates[indexPath.row].bio
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
        self.candidates = model?.getCandidates() ?? candidates
        tableView.reloadData()
    }
}

extension VoteViewController {
    // This function will create an alertView that seals one's vote
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something with AlertView, which has an action completion to call didVote
        let finalVoteAlert = UIAlertController(title: "Cast Vote?", message: "You can only vote once, all votes are final!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let castAction = UIAlertAction(title: "Vote", style: .default) { [weak self] action in
            self?.didVoteForCandidate(candidate: self?.candidates[indexPath.row])
        }
        finalVoteAlert.addAction(cancelAction)
        finalVoteAlert.addAction(castAction)
        present(finalVoteAlert, animated: true, completion: nil)
    }

    func didVoteForCandidate(candidate: Candidate?) {
        if let castVote = candidate {
            controlManager.voteForCandidate(candidate: castVote.getName()) { updatedCandidates in
                guard updatedCandidates != nil else {
                    //TODOluke: attempted to vote but failed
                    return
                }
                self.delegate?.didVote(candidate: castVote)
            }
        }
    }

}

