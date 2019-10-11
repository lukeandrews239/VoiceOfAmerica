//
//  CandidateProtocol.swift
//  VoiceOfAmerica
//
//  Created by Isaak Meier on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation

protocol CandidateDelegate: AnyObject {
    func getNumCandidates() -> Int
}
