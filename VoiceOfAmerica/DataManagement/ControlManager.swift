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
}
