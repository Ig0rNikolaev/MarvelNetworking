//
//  MarvelTabelView.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import UIKit

class MarvelTabelView: UIViewController, UITableViewDelegate {

    //MARK: - Outlets

    lazy var tabelView: UITableView = {
        let tabelView = UITableView(frame: .zero, style: .plain)
        tabelView.register(MarvelTabelCell.self, forCellReuseIdentifier: MarvelTabelCell.identifier)
        tabelView.backgroundColor = .black
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

extension MarvelTabelView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        25
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarvelTabelCell.identifier, for: indexPath)
        return cell
    }
}
