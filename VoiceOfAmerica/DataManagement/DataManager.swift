//
//  DataManager.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/10/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation
import Firebase

// Lowest level manager for interfacing with APIs, performing requests, etc.
class DataManager {

    // Only direct reference to the database within the app (private)
    private let databaseReference = Database.database().reference()

    // Callback provided by Firebase TODOluke: Add error handling
    typealias FirebaseCompletion = (_ error: Error?, _ ref: DatabaseReference?) -> ()

    // Request typealias
    typealias FirebaseSnapshot = (DataSnapshot?) -> ()

    // Takes a completion block for execution upon reception of command response
    func addNewPrimaryEntry(entryData: String, completion: @escaping FirebaseCompletion) {
        databaseReference.setValue(entryData, withCompletionBlock: completion)
    }

    // Get the current state of all candidates
    func getCurrentStateValues(completion: @escaping FirebaseSnapshot) {
        //databaseReference.child("PresidentialCandidates").observeSingleEvent(of: .value, with: completion)
        databaseReference.child("PresidentialCandidates").runTransactionBlock({ (curData: MutableData) -> TransactionResult in
            return TransactionResult.success(withValue: curData)
        }) { (error: Error?, committed: Bool, snapshot: DataSnapshot?) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else {
                completion(snapshot)
            }
        }
    }

    // Request to update a value - exclusively used as a transaction parameter to prevent concurrent mutation requests
    func updateVoteParameterRequest(candidate: String, completion: @escaping (Bool, DataSnapshot?) -> ()) {
        databaseReference.child("PresidentialCandidates").runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            var votes : Int?
            if var candidates = currentData.value as? [String: AnyObject] {
                candidates.forEach { entry in
                    let (name, tally) = entry
                    if name == candidate {
                        if let currentVotes = tally as? Int {
                            votes = currentVotes + 1
                        } else {
                            // TODOluke: add error handling (Transaction failure - unable to disambiguate vote tally)
                        }
                    }
                }
                if let newTally = votes {
                    candidates[candidate] = newTally as AnyObject?
                    currentData.value = candidates
                }
            }
            return TransactionResult.success(withValue: currentData)
        }) { (error: Error?, committed: Bool, snapshot: DataSnapshot?) in
            if let error = error {
                print(error.localizedDescription)
                completion(false, nil)
            } else {
                //TODOluke: could have failed to commit without throwing an error
                completion(committed, snapshot)
            }
        }
    }
}
