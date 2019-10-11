//
//  CandidatesDataSource.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation

struct CandidatesDataSource {
    private static let candidates = ["Michael Bennet": "Senator from Colorado",
                                     "Joseph R Biden Jr": "Former vice president; former senator from Delaware",
                                     "Cory Booker": "Senator from New Jersey; former mayor of Newark",
                                     "Steve Bullock": "Governor of Montana; former state attorney general",
                                     "Pete Buttigieg": "Mayor of South Bend, Ind.; military veteran",
                                     "Julian Castro": "Former housing secretary; former mayor of San Antonio",
                                     "John Delaney": "Former congressman from Maryland; former businessman",
                                     "Tulsi Gabbard": "Congresswoman from Hawaii; Army National Guard veteran",
                                     "Kamala Harris": "Senator from California; former attorney general of California; former San Francisco district attorney",
                                     "Amy Klobuchar": "Senator from Minnesota; former Hennepin County, Minn., attorney",
                                     "Wayne Messam": "Mayor of Miramar, Fla.; former college football champion",
                                     "Beto O'Rourke": "Former congressman from Texas; 2018 Senate candidate",
                                     "Tim Ryan": "Congressman from Ohio; former congressional staff member",
                                     "Bernie Sanders": "Senator from Vermont; former congressman",
                                     "Mark Sanford": "Former congressman from South Carolina, former governor of the state",
                                     "Joe Sestak": "Former congressman from Pennsylvania; former Navy admiral",
                                     "Tom Steyer": "Billionaire former hedge fund executive; climate change and impeachment activist",
                                     "Donald J Trump": "U.S. president; real estate developer; reality television star",
                                     "Joe Walsh": "Conservative radio show host; former congressman from Illinois",
                                     "Elizabeth Warren": "Senator from Massachusetts; former Harvard professor",
                                     "William F Weld": "Former governor of Massachusetts; former federal prosecutor",
                                     "Marianne Williamson": "Self-help author, new age lecturer",
                                     "Andrew Yang": "Former tech executive who founded an economic development nonprofit" ]

    static func generateCandidates() -> [String: String] {
        return candidates
    }

    static func generateNames() -> [String] {
        var names = [String]()
        for c in candidates {
            names.append(c.key)
        }
        return names
    }

    static func generateBios() -> [String] {
        var names = [String]()
        for c in candidates {
            names.append(c.value)
        }
        return names
    }
}
