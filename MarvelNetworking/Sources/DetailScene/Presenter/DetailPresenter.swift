//
//  ModalPresenter.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 13.03.2023.
//

import Foundation

protocol DetailViewProtocol {
    func setDetailCharacter(_ character: Character?)
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, networkServise: NetworkServiceProtocol, character: Character?)
    func setDetailCharacter()
}

class DetailPresenter: DetailPresenterProtocol {
    
    var networkService: NetworkServiceProtocol
    var view: DetailViewProtocol?
    var character: Character?
    
    required init(view: DetailViewProtocol, networkServise: NetworkServiceProtocol, character: Character?) {
        self.view = view
        self.networkService = networkServise
        self.character = character
    }
    
    func setDetailCharacter() {
        self.view?.setDetailCharacter(character)
    }
}
