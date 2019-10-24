//
//  ControlManager.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/10/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation
import Firebase

// Singleton access limiter between ViewControllers and API requests (dataManager)
class ControlManager {

    // Shared instance, accessible by class function
    private static let singletonInstance = ControlManager.init()

    // DataManager reference

    private let dataManager = DataManager.init()

    // Only ControlManager can create instances of itself
    private init() {

    }

    // Returns the shared instance of this class
    static func shared() -> ControlManager {
        return self.singletonInstance
    }

    func addNewPrimaryEntry(entry: String, completion: @escaping (DatabaseReference?) -> Void) {
        let handler = { (_ error: Error?, _ reference: DatabaseReference?) in
            // Deal with error
            if let taskError = error {
                print(taskError, "Failed to add entry: ", entry)
                completion(nil)
            } else if reference != nil {
                // Success, pass along the database reference
                completion(reference)
            }
        }
        dataManager.addNewPrimaryEntry(entryData: entry, completion: handler)
    }

    // Request for current candidate values from the backend
    func getCurrentStateValues(completion: @escaping (NSDictionary?) -> ()) {
        let handler = { (response: DataSnapshot?) in
            if let packet = response?.value as? NSDictionary {
                completion(packet)
            } else {
                completion(nil)
            }
        }
        dataManager.getCurrentStateValues(completion: handler)
    }

    // Make a transaction-protected vote for a candidate
    func voteForCandidate(candidate: String, completion: @escaping (NSDictionary?) -> ()) {
        let handler = { (committed: Bool, currentData: DataSnapshot?) in
            if let packet = currentData?.value as? NSDictionary, committed {
                // Successfully committed the vote to the backend
                completion(packet)
            } else {
                // Failed to commit the vote
                completion(nil)
            }
        }
        dataManager.updateVoteParameterRequest(candidate: candidate, completion: handler)
    }
}
