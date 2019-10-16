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

    private let circleImage: UIImage = {
        var trump = UIImage(named: "donald-trump")
        var image = UIImageView(image: trump)
        let layer = image.layer
        layer.masksToBounds = true
        layer.cornerRadius = trump!.size.width / 2
        UIGraphicsBeginImageContext(image.bounds.size)

        layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let roundedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return trump!
        }
        UIGraphicsEndImageContext()

        return roundedImage
    }()

    private lazy var nameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, bioLabel])
        stack.axis = .vertical
        stack.spacing = 3
        stack.alignment = .fill
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
        contentView.addSubview(nameStack)

        // Style

        // Layout
        nameStack.centerYAnchor == contentView.centerYAnchor
        nameStack.leadingAnchor == contentView.leadingAnchor + 20
    }
}
