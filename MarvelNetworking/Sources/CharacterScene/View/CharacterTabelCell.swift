//
//  MarvelTabelCellTableViewCell.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit

class CharacterTabelCell: UITableViewCell {
    
    static let identifier = "CharacterTabelCell"
    
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
    
    private var nameCharacterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 15.5, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    //MARK: - Lifecycle
    
    override init(style: CharacterTabelCell.CellStyle, reuseIdentifier: String?) {
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
        contentView.addSubview(nameCharacterLabel)
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
            imageСharacter.leftAnchor.constraint(equalTo: imageСonteiner.leftAnchor),
            
            nameCharacterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameCharacterLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameCharacterLabel.leftAnchor.constraint(equalTo: imageСonteiner.rightAnchor, constant: 5)
        ])
    }

    func createCharacterCell(_ character: Character?) {
        let creatureImageURL = CreatureImageURL()
        nameCharacterLabel.text = character?.name ?? " "
        creatureImageURL.getDataImageСharacter(urlRequest: character?.thumbnail?.url, imageСharacter: imageСharacter)
    }
}
