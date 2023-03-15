//
//  MarvelTabelCellTableViewCell.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit

final class CharacterTabelCell: UITableViewCell {
    
    static let identifier = "CharacterTabelCell"
    
    private lazy var imageСharacter: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var imageСharacterСonteiner: UIView = {
        let image = UIView()
        image.backgroundColor = .systemBlue
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameCharacterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionCharacterStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.addArrangedSubview(nameCharacterLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    //MARK: - Lifecycle
    
    override init(style: CharacterTabelCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
        backgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Setup

    private func backgroundColor() {
        contentView.backgroundColor = .systemGray6
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageСharacter.image = nil
        nameCharacterLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func setupHierarchy() {
        imageСharacterСonteiner.addSubview(imageСharacter)
        contentView.addSubview(imageСharacterСonteiner)
        contentView.addSubview(descriptionCharacterStack)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageСharacterСonteiner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageСharacterСonteiner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            imageСharacterСonteiner.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageСharacterСonteiner.widthAnchor.constraint(equalToConstant: 155),
            imageСharacterСonteiner.heightAnchor.constraint(equalToConstant: 155),

            imageСharacter.topAnchor.constraint(equalTo: imageСharacterСonteiner.topAnchor),
            imageСharacter.rightAnchor.constraint(equalTo: imageСharacterСonteiner.rightAnchor),
            imageСharacter.bottomAnchor.constraint(equalTo: imageСharacterСonteiner.bottomAnchor),
            imageСharacter.leftAnchor.constraint(equalTo: imageСharacterСonteiner.leftAnchor),

            descriptionCharacterStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionCharacterStack.leftAnchor.constraint(equalTo: imageСharacterСonteiner.rightAnchor, constant: 50),
            descriptionCharacterStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionCharacterStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

extension CharacterTabelCell: CharacterLoadProtocol {
    func createCharacterCell(_ character: Character?) {
        let creatureImageURL = CreatureImageURL()
        nameCharacterLabel.text = character?.name ?? " "
        descriptionLabel.text = character?.description ?? " "
        creatureImageURL.getDataImageСharacter(urlRequest: character?.thumbnail?.url, imageСharacter: imageСharacter)
    }
}
