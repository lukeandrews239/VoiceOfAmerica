//
//  CandidateModel.swift
//  VoiceOfAmerica
//
//  Created by Isaak Meier on 10/10/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit
import Foundation

class CandidateModel {
    var candidates = [Candidate]()

    private let controlSingleton = ControlManager.shared()

    private let data = CandidatesDataSource.generateCandidates()

    var delegate: CoordinatorDelegate?

    typealias DataCompletion = ([Candidate], CandidateDelegate) -> ()

    init(dataCompletion: DataCompletion?) {
        makeCandidates(completion: dataCompletion)
    }

    func makeCandidates(completion: DataCompletion?) {
        var candidateData: NSDictionary = NSDictionary()
        let group = DispatchGroup()
        group.enter()
        controlSingleton.getCurrentStateValues { (response: NSDictionary?) in
            if let packet = response {
                candidateData = packet
                group.leave()
            } else {
                // Request failed, TODOluke error alert for bad network connection
                print(response ?? "Failed request")
                group.leave()
                return
            }
        }
        group.notify(queue: .main, work: DispatchWorkItem(block: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            for entry in candidateData {
                if let name = entry.key as? String, let voteTally = entry.value as? Int {
                    // TODOisaak: we need to get correct bio and images here
                    let bio = weakSelf.data[name]
                    weakSelf.candidates.append(Candidate(name: name, bio: bio ?? "Dic/Server mismatch", face: UIImageView(), votes: voteTally))
                }
            }
            if let dataCompletion = completion {
                dataCompletion(weakSelf.candidates, weakSelf)
            } else {
                weakSelf.delegate?.didFinishLoadingData()
            }
        }))
    }
}

struct Candidate {
    var name: String
    var bio: String
    var face: UIImageView
    var votes: Int

    func getName() -> String {
        return name
    }

    func getVote() -> Int {
        return votes
    }
}

extension CandidateModel: CandidateDelegate {
    func getCandidates() -> [Candidate] {
        return candidates
    }
}

extension FlowCoordinator {
    func didFinishLoadingData() {
        voteViewController?.refreshData()
    }
}
    
