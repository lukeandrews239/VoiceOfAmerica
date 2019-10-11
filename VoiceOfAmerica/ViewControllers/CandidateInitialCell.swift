//
//  CandidateInitialCell.swift
//  VoiceOfAmerica
//
//  Created by Isaak Meier on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit
import Foundation

final class CandidateInitialCell: UITableViewCell {

    static let identifier = "CandidateInitialCell"

    var nameText: String = "" {
        didSet {
            let attributeString = NSAttributedString(string: nameText, attributes:
                [.font: Fonts.primaryText,
                 .foregroundColor: UIColor.white,
                 .kern: 0.03])

            nameLabel.attributedText = attributeString
        }
    }

    var bioText: String = "" {
        didSet {
            let attributeString = NSAttributedString(string: nameText, attributes:
                [.font: Fonts.secondaryText,
                 .foregroundColor: UIColor.white,
                 .kern: 0.03])

            bioLabel.attributedText = attributeString
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        return label
    }()

}
