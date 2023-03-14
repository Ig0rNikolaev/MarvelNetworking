//
//  MarvelPresenter.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

protocol CharacterLoadProtocol {
    func createCharacterCell(_ character: Character?)
}

protocol CharacterViewProtocol {
    func succes()
    func failure(error: Error)
}

protocol CharacterPresenterProtocol {
    var charactersData: CharacterData? { get set }
    var characterView: CharacterViewProtocol? { get set }
    init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol)
    func getCharacter()
}

class CharacterPresenter: CharacterPresenterProtocol {

    //MARK: - Outlets

    var networkService: NetworkServiceProtocol
    var characterView: CharacterViewProtocol?
    var charactersData: CharacterData?

    //MARK: - Initializer

    required init(view: CharacterViewProtocol, networkService: NetworkServiceProtocol) {
        self.characterView = view
        self.networkService = networkService
        getCharacter()
    }

    //MARK: - Setup
    
    func getCharacter() {
        networkService.getData(name: nil) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let characters):
                    self.charactersData = characters
                    self.characterView?.succes()
                case .failure(let error):
                    self.characterView?.failure(error: error)
            }
        }
    }
}
