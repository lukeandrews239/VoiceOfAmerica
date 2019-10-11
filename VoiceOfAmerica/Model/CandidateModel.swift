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
    let candidateDataSource = CandidatesDataSource.generateCandidates()

    init() {
        makeCandidates()
    }

    func makeCandidates() {
        // this is where we create the entire model.
        // we're going to need to get the votes here somehow.
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

    
