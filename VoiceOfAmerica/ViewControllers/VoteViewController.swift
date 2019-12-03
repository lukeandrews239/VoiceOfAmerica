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

    private var searchController: UISearchController?

    private var isFiltering: Bool {
        return searchController?.isActive ?? false && !searchEmpty
    }

    private var searchEmpty: Bool {
        return searchController?.searchBar.text?.isEmpty ?? true
    }

    private var candidates = [Candidate]()

    private var filteredCandidates = [Candidate]()

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
        layoutViews()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredCandidates.count : candidates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateInitialCell.identifier) as! CandidateInitialCell
        cell.nameText = isFiltering ? filteredCandidates[indexPath.row].getName() : candidates[indexPath.row].getName()
        cell.bioText = isFiltering ? filteredCandidates[indexPath.row].bio : candidates[indexPath.row].bio
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

        // Search Bar
        self.configureSearchBar()

    }

    func refreshData() {
        self.candidates = model?.getCandidates() ?? candidates
        self.filteredCandidates = candidates
        tableView.reloadData()
    }

    func configureSearchBar() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchResultsUpdater = self
        self.searchController?.obscuresBackgroundDuringPresentation = false
        self.searchController?.searchBar.placeholder = "Search Candidates..."
        self.searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension VoteViewController {
    // This function will create an alertView that seals one's vote
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do something with AlertView, which has an action completion to call didVote
        let finalVoteAlert = UIAlertController(title: "Cast Vote?", message: "You can only vote once, all votes are final!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            if !(self.filteredCandidates.isEmpty) {
                self.searchController?.isActive = true
                self.searchController!.searchBar.becomeFirstResponder()
            }
        }
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

extension VoteViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController?.isActive = false
        self.searchController?.resignFirstResponder()
        self.filteredCandidates = [Candidate]()
    }
}

extension VoteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.filteredCandidates = filteredCandidates(curText: searchText)
            tableView.reloadData()
        }
    }

    private func filteredCandidates(curText: String) -> [Candidate] {
        return self.candidates.filter { $0.getName().localizedCaseInsensitiveContains(curText)}
    }

}

