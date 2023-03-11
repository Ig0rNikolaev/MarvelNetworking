//
//  MarvelPresenter.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import Foundation

protocol CharacterViewProtocol {
    func succes()
    func failure(error: Error)
}

protocol CharacterPresenterProtocol {
    var characterData: CharacterData? { get set }
    init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol)
    func getCharacter()
}

class CharacterPresenter: CharacterPresenterProtocol {

    //MARK: - Outlets
    var networkService: NetworkServiceProtocol
    var characterView: CharacterViewProtocol?
    var characterData: CharacterData?

    //MARK: - Initializer

    required init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol) {
        self.characterView = view
        self.networkService = networkService
        getCharacter()
    }

    //MARK: - Setup

    func getCharacter() {
        networkService.getData { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let characters):
                    self.characterData = characters
                    self.characterView?.succes()
                case .failure(let error):
                    self.characterView?.failure(error: error)
                }
            }
        }
    }
}
