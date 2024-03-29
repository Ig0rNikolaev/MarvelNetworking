//
//  DetailView.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 13.03.2023.
//

import UIKit

fileprivate enum Constants {
    static let imageDetailUIImageNamed = "Marvel"
}

final class DetailCharacterView: UIViewController {
    
    var presenter: DetailPresenterProtocol?

    //MARK: - Outlets
    
    private lazy var imageDetailMarvel: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: Constants.imageDetailUIImageNamed)
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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
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
        presenter?.setDetailCharacter(imageСharacter: imageDetailCharacter)
    }
    
    private func backgroundColor() {
        view.backgroundColor = .systemGray6
    }
    
    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubviews([imageDetailMarvel, 
                                nameDetailCharacter,
                                imageDetailCharacter, 
                                descriptionDetailLabel,
                                comixDetailLabel])
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            imageDetailMarvel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            imageDetailMarvel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            imageDetailMarvel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            imageDetailMarvel.topAnchor.constraint(equalTo: imageDetailMarvel.bottomAnchor, constant: -100),

            nameDetailCharacter.topAnchor.constraint(equalTo: imageDetailMarvel.bottomAnchor, constant: 10),
            nameDetailCharacter.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            nameDetailCharacter.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            nameDetailCharacter.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            imageDetailCharacter.topAnchor.constraint(equalTo: nameDetailCharacter.bottomAnchor, constant: 10),
            imageDetailCharacter.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            imageDetailCharacter.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            imageDetailCharacter.topAnchor.constraint(equalTo: imageDetailCharacter.bottomAnchor, constant: -400),

            descriptionDetailLabel.topAnchor.constraint(equalTo: imageDetailCharacter.bottomAnchor, constant: 10),
            descriptionDetailLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            descriptionDetailLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            descriptionDetailLabel.bottomAnchor.constraint(equalTo: comixDetailLabel.topAnchor, constant: -10),

            comixDetailLabel.topAnchor.constraint(equalTo: descriptionDetailLabel.bottomAnchor, constant: 10),
            comixDetailLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            comixDetailLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            comixDetailLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
        ])
    }
}

//MARK: - Extensions

extension DetailCharacterView: DetailViewProtocol {
    func setDetailCharacter(_ character: Character?) {
        nameDetailCharacter.text = character?.name ?? " "
        descriptionDetailLabel.text = character?.description ?? " "
        guard let comics = character?.comics?.items else { return comixDetailLabel.text = ""}
        let comicNames = comics.compactMap { $0.name }.joined(separator: ", ")
        comixDetailLabel.text = comicNames
    }
}
