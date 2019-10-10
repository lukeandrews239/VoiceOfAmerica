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

    // Takes a completion block for execution upon reception of command response
    func addNewPrimaryEntry(entryData: String, completion: @escaping FirebaseCompletion) {
        databaseReference.setValue(entryData, withCompletionBlock: completion)
    }
}
