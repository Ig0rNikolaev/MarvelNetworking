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
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.translatesAutoresizingMaskIntoConstraints = false
        return tabelView
    }()


    //: MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()

    }

    //: MARK: - Setups

    private func setupHierarchy() {
        view.addSubview(tabelView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            tabelView.topAnchor.constraint(equalTo: view.topAnchor),
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
}

extension CharacterTabelView: CharacterViewProtocol {
    func succes() {
        tabelView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
