//
//  Coordinator.swift
//  VoiceOfAmerica
//
//  Created by Luke Andrews on 10/9/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import Foundation
import UIKit

// Protocol that all Coordinator objects must abide by
protocol Coordinator {

    // Navigation Controller, passed via dependency injection
    var navigationController: UINavigationController { get set }

    // Begin the flow
    func start()
}
