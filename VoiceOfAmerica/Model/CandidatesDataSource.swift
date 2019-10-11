//
//  CandidatesDataSource.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation

struct CandidatesDataSource {
    private static let candidates = ["Michael Bennet",
                                     "Joseph R Biden Jr",
                                     "Cory Booker",
                                     "Steve Bullock",
                                     "Pete Buttigieg",
                                     "Julian Castro",
                                     "John Delaney",
                                     "Kamala Harris",
                                     "Amy Klobuchar",
                                     "Wayne Messam",
                                     "Beto O'Rourke",
                                     "Tim Ryan",
                                     "Bernie Sanders",
                                     "Mark Sanford",
                                     "Joe Sestak",
                                     "Tom Steyer",
                                     "Donald J Trump",
                                     "Joe Walsh",
                                     "William F Weld",
                                     "Marianne Williamson",
                                     "Andrew Yang"]

    static func generateCandidates() -> [String] {
        return candidates
    }
}
