//
//  DetailView.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 13.03.2023.
//

import Foundation
import UIKit

class DetailCharacterView: UIViewController {

    var presenter: DetailPresenter?

    //MARK: - Outlets

    private lazy var imageDetailMarvel: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "Marvel")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var nameDetailCharacter: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageDetailCharacter: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var descriptionDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = .max
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var comixDetailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = .max
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setDetail()
        setupHierarchy()
        setupLayout()
        backgroundColor()
    }

    //: MARK: - Setups

    private func setDetail() {
        presenter?.setDetailCharacter()
    }

    private func backgroundColor() {
        view.backgroundColor = .white
    }

    private func setupHierarchy() {
        view.addSubview(imageDetailMarvel)
        view.addSubview(nameDetailCharacter)
        view.addSubview(imageDetailCharacter)
        view.addSubview(descriptionDetailLabel)
        view.addSubview(comixDetailLabel)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageDetailMarvel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageDetailMarvel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            imageDetailMarvel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            imageDetailMarvel.topAnchor.constraint(equalTo: imageDetailMarvel.bottomAnchor, constant: -100),

            nameDetailCharacter.topAnchor.constraint(equalTo: imageDetailMarvel.bottomAnchor, constant: 10),
            nameDetailCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            nameDetailCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            nameDetailCharacter.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            imageDetailCharacter.topAnchor.constraint(equalTo: nameDetailCharacter.bottomAnchor, constant: 10),
            imageDetailCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            imageDetailCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            imageDetailCharacter.topAnchor.constraint(equalTo: imageDetailCharacter.bottomAnchor, constant: -400),

            descriptionDetailLabel.topAnchor.constraint(equalTo: imageDetailCharacter.bottomAnchor, constant: 10),
            descriptionDetailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionDetailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionDetailLabel.bottomAnchor.constraint(equalTo: comixDetailLabel.topAnchor, constant: -10),

            comixDetailLabel.topAnchor.constraint(equalTo: descriptionDetailLabel.bottomAnchor, constant: 10),
            comixDetailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            comixDetailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
        ])
    }
}

extension DetailCharacterView: DetailViewProtocol {
    func setDetailCharacter(_ character: Character?) {
        let creatureImageURL = CreatureImageURL()
        nameDetailCharacter.text = character?.name ?? " "
        descriptionDetailLabel.text = character?.description ?? " "
        creatureImageURL.getDataImageСharacter(urlRequest: character?.thumbnail?.url, imageСharacter: imageDetailCharacter)
        if let character = character {
            if let comics = character.comics?.items {
                let comicNames = comics.compactMap { $0.name }.joined(separator: ", ")
                comixDetailLabel.text = comicNames
            }
        }
    }
}
    
