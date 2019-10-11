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
        for i in 0..<candidateDataSource.count {
            let name = candidateDataSource[i]
            let bio = "Placeholder bio" // hardcoded?
            let votes = 0 // get votes per candidate here
            let face = UIImage(named: "trump-face")  // placeholder image
            let faceView = UIImageView(image: face)
            let candidate = Candidate(name: name, bio: bio, face: faceView, votes: votes)
            candidates.append(candidate)
        }
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

    
