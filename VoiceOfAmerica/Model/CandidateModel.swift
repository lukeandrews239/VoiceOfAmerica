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

    init() {
        makeCandidates()
    }

    func makeCandidates() {
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
                    weakSelf.candidates.append(Candidate(name: name, bio: "", face: UIImageView(), votes: voteTally))
                }
            }
        }))
    }
}

struct Candidate {
    var name: String
    var bio: String
    var face: UIImageView
    var votes: Int


    init(name: String, bio: String, face: UIImageView, votes:Int) {
        self.name = name
        self.bio = bio
        self.face = face
        self.votes = votes
    }
}

extension CandidateModel: CandidateDelegate {

    func getNumCandidates() -> Int {
        return candidates.count
    }
}

    
