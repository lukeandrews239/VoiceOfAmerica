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

    init(with controller: UINavigationController) {
        self.navigationController = controller
    }

    // Kick off application by instantiating and presenting a new instance of the VoteVC
    func start() {
        let voteVC = VoteViewController()
        let model = CandidateModel()
        voteVC.delegate = self
        voteVC.model = model
        self.voteViewController = voteVC
        self.navigationController.pushViewController(voteVC, animated: true)
    }
}

extension FlowCoordinator: CoordinatorDelegate {
    func didVote(candidate: String) {
        //TODOluke
    }
}
