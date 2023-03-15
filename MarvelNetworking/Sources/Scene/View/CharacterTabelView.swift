//
//  MarvelTabelView.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit
import Alamofire

class CharacterTabelView: UIViewController {
    
    //MARK: - Outlets
    
    var presenter: CharacterPresenterProtocol?
    
    lazy var tabelView: UITableView = {
        let tabelView = UITableView(frame: .zero, style: .plain)
        tabelView.register(CharacterTabelCell.self, forCellReuseIdentifier: CharacterTabelCell.identifier)
        tabelView.backgroundColor = .systemGray6
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
        textField.textAlignment = .center
        textField.textColor = .systemBlue
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.setupLeftImage(imageName: "magnifyingglass")
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "SEARCH...",
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var searchButtonCharacter: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        button.shadowButton()
        button.setTitle("CHOOSE YOUR SUPERHERO", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15.5, weight: .heavy)
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //: MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        backgroundColor()
    }
    
    //: MARK: - Setups
    
    @objc private func search() {
        let networkService = NetworkService()
        networkService.getData(name: searchCharacter.text) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                if let results = characters?.data?.results, results.contains(where: { $0.name?.range(of: self.searchCharacter.text ?? " ",
                                                                                                     options: .caseInsensitive) != nil }) {
                    self.presenter?.charactersData = characters
                    self.presenter?.characterView?.succes()
                } else {
                    self.showAllert()
                }
            case .failure(let error):
                self.presenter?.characterView?.failure(error: error)
            }
        }
    }

    func showAllert() {
        let alert = UIAlertController(title: "Персонаж не найден",
                                      message: "Персонаж не существует во вселенной Marvel",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .destructive, handler:  { event in
            self.searchCharacter.text = ""
        }))
        self.present(alert, animated: true)
    }

    private func backgroundColor() {
        view.backgroundColor = .systemGray6
    }

    private func setupHierarchy() {
        imageMarvelСonteiner.addSubview(imageMarvel)
        view.addSubview(imageMarvelСonteiner)
        view.addSubview(searchCharacter)
        view.addSubview(searchButtonCharacter)
        view.addSubview(tabelView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageMarvelСonteiner.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageMarvelСonteiner.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            imageMarvelСonteiner.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            imageMarvelСonteiner.topAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor, constant: -100),

            imageMarvel.topAnchor.constraint(equalTo: imageMarvelСonteiner.topAnchor),
            imageMarvel.rightAnchor.constraint(equalTo: imageMarvelСonteiner.rightAnchor),
            imageMarvel.bottomAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor),
            imageMarvel.leftAnchor.constraint(equalTo: imageMarvelСonteiner.leftAnchor),

            searchCharacter.topAnchor.constraint(equalTo: imageMarvelСonteiner.bottomAnchor, constant: 10),
            searchCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchCharacter.topAnchor.constraint(equalTo: searchCharacter.bottomAnchor, constant: -39),

            searchButtonCharacter.topAnchor.constraint(equalTo: searchCharacter.bottomAnchor, constant: 10),
            searchButtonCharacter.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchButtonCharacter.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchButtonCharacter.topAnchor.constraint(equalTo: searchButtonCharacter.bottomAnchor, constant: -49),

            tabelView.topAnchor.constraint(equalTo: searchButtonCharacter.bottomAnchor),
            tabelView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabelView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

extension CharacterTabelView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.charactersData?.data?.results?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTabelCell.identifier,
                                                       for: indexPath) as? CharacterTabelCell else { return UITableViewCell() }
        let marvelCharacter = presenter?.charactersData?.data?.results?[indexPath.row]
        cell.createCharacterCell(marvelCharacter)
        return cell
    }
}

extension CharacterTabelView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = presenter?.charactersData?.data?.results?[indexPath.row] else { return }
        let detailCharacterView = Builder.createView(character: character)
        if let sheet = detailCharacterView.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(detailCharacterView, animated: true)
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
