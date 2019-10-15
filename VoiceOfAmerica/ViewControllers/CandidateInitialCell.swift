//
//  CandidateInitialCell.swift
//  VoiceOfAmerica
//
//  Created by Isaak Meier on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit
import BonMot
import Foundation

final class CandidateInitialCell: UITableViewCell {

    static let identifier = "CandidateInitialCell"

    var nameText: String = "" {
        didSet {
            nameLabel.attributedText = nameText.styled(with:.font(Fonts.primaryText),.alignment(.center))
        }
    }

    var bioText: String = "" {
        didSet {
            bioLabel.attributedText = bioText.styled(with:.font(Fonts.secondaryText),.alignment(.center))
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()

}
