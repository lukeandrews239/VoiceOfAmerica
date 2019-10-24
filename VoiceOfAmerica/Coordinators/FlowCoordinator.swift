//
//  FlowCoordinator.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/9/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation
import UIKit

// Governs the main application architecture
class FlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    var voteViewController: VoteViewController?
    var model: CandidateModel?
    var pollDataViewController: PollDataViewController?

    init(with controller: UINavigationController) {
        self.navigationController = controller
    }

    // Kick off application by instantiating and presenting a new instance of the VoteVC
    func start() {
        let voteVC = VoteViewController()
        let model = CandidateModel(dataCompletion: nil)
        self.model = model
        voteVC.delegate = self
        voteVC.model = model
        model.delegate = self
        self.voteViewController = voteVC
        self.navigationController.pushViewController(voteVC, animated: true)
    }
}

extension FlowCoordinator: CoordinatorDelegate {
    func didVote(candidate: Candidate) {
        self.model = nil
        self.voteViewController = nil
        let handler: ([Candidate], CandidateDelegate) -> () = { [weak self] candidates, model in
            guard let weakSelf = self else {
                // TODOluke: Coordinator deallocated? Maybe throw fatal error
                return
            }
            // Optimal time to end loading bar if we go that route
            let pollVC = PollDataViewController()
            weakSelf.pollDataViewController = pollVC
            pollVC.delegate = self
            pollVC.recieveDataAndReload(candidateList: candidates)
        }
        let model = CandidateModel(dataCompletion: handler)
        self.model = model
        // TODOluke: kickoff loading here
    }
}
