//
//  CandidateInitialCell.swift
//  VoiceOfAmerica
//
//  Created by Isaak Meier on 10/11/19.
//  Copyright © 2019 Luke Andrews. All rights reserved.
//

import UIKit
import BonMot
import Anchorage
import Foundation

final class CandidateInitialCell: UITableViewCell {

    static let identifier = "CandidateInitialCell"

    var nameText: String = "" {
        didSet {
            nameLabel.attributedText = nameText.styled(with:.font(Fonts.primaryText),.alignment(.left), .lineBreakMode(.byWordWrapping))
        }
    }

    var bioText: String = "" {
        didSet {
            bioLabel.attributedText = bioText.styled(with:.font(Fonts.secondaryText),.alignment(.left), .lineBreakMode(.byWordWrapping))
            bioLabel.numberOfLines = 0
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

    private let circleImage: UIImageView = {
        var trump = UIImage(named: "donald-trump")
        var image = UIImageView(image: trump)
        image.layer.masksToBounds = true

        var desiredSide: CGFloat = 70

        image.layer.cornerRadius = desiredSide / 2
        image.setContentHuggingPriority(.required, for: .horizontal)
        image.setContentHuggingPriority(.required, for: .vertical)
        image.sizeAnchors == CGSize(width: desiredSide, height: desiredSide)
        return image
    }()

    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .fill
        return stack
    }()

    private lazy var fullStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [circleImage, nameStack])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CandidateInitialCell {
    func configureViews() {
        // Heirarchy
        contentView.addSubview(fullStack)

        // Style
        let safeAreaGuide = contentView.layoutMarginsGuide

        // Layout
        fullStack.edgeAnchors == safeAreaGuide.edgeAnchors

    }
}
