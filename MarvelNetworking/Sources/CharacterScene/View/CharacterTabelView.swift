//
//  MarvelTabelView.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit

class CharacterTabelView: UIViewController {

    //MARK: - Outlets

    var presenter: CharacterPresenterProtocol?

    lazy var tabelView: UITableView = {
        let tabelView = UITableView(frame: .zero, style: .plain)
        tabelView.register(CharacterTabelCell.self, forCellReuseIdentifier: CharacterTabelCell.identifier)
        tabelView.backgroundColor = .white
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        return tabelView
    }()

    private lazy var imageMarvel: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "Marvel")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var imageMarvelСonteiner: UIView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var searchCharacter: UITextField = {
        let textField = UITextField()
        let color = UIColor.white
        textField.placeholder = "SEARCH"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? " ", attributes: [NSAttributedString.Key.foregroundColor : color])
        textField.backgroundColor = .systemBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var searchButtonCharacter: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("CHOOSE YOUR SUPERHERO", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.5, weight: .heavy)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        view.backgroundColor = .white
    }

    //: MARK: - Setups

    private func setupHierarchy() {
        imageMarvelСonteiner.addSubview(imageMarvel)
        view.addSubview(imageMarvelСonteiner)
        view.addSubview(searchCharacter)
        view.addSubview(searchButtonCharacter)
        view.addSubview(tabelView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageMarvelСonteiner.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            imageMarvelСonteiner.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageMarvelСonteiner.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageMarvelСonteiner.topAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor, constant: -100),

            imageMarvel.topAnchor.constraint(equalTo: imageMarvelСonteiner.topAnchor, constant: 30),
            imageMarvel.rightAnchor.constraint(equalTo: imageMarvelСonteiner.rightAnchor, constant: -10),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor),
            imageMarvel.leftAnchor.constraint(equalTo: imageMarvelСonteiner.leftAnchor, constant: 10),

            searchCharacter.topAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor, constant: 10),
            searchCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchCharacter.topAnchor.constraint(equalTo: searchCharacter.bottomAnchor, constant: -30),

            searchButtonCharacter.topAnchor.constraint(equalTo: searchCharacter.bottomAnchor, constant: 10),
            searchButtonCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchButtonCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchButtonCharacter.topAnchor.constraint(equalTo: searchButtonCharacter.bottomAnchor, constant: -39),

            tabelView.topAnchor.constraint(equalTo: searchButtonCharacter.bottomAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabelView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

extension CharacterTabelView: UITableViewDataSource, UITableViewDelegate {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.characterData?.data?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTabelCell.identifier, for: indexPath) as? CharacterTabelCell else { return UITableViewCell() }
        let marvelCharacter = presenter?.characterData?.data?.results?[indexPath.row]
        cell.createCharacterCell(marvelCharacter)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

extension CharacterTabelView: CharacterViewProtocol {
    func succes() {
        tabelView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
