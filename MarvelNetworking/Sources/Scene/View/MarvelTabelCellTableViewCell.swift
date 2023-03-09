//
//  MarvelTabelCellTableViewCell.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit

class MarvelTabelCell: UITableViewCell {

    static let identifier = "MarvelTabelCell"

    private lazy var imageСharacter: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var imageСonteiner: UIView = {
        let image = UIImageView()
        image.backgroundColor = .systemBlue
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    //MARK: - Lifecycle

    override init(style: MarvelTabelCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - Setup

    private func setupHierarchy() {
        imageСonteiner.addSubview(imageСharacter)
        contentView.addSubview(imageСonteiner)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            imageСonteiner.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageСonteiner.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -175),
            imageСonteiner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageСonteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor),

            imageСharacter.topAnchor.constraint(equalTo: imageСonteiner.topAnchor),
            imageСharacter.rightAnchor.constraint(equalTo: imageСonteiner.rightAnchor),
            imageСharacter.bottomAnchor.constraint(equalTo: imageСonteiner.bottomAnchor),
            imageСharacter.leftAnchor.constraint(equalTo: imageСonteiner.leftAnchor)
        ])
    }
}
