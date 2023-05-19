//
//  ModalPresenter.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 13.03.2023.
//

protocol DetailViewProtocol: AnyObject {
    func setDetailCharacter(_ character: Character?)
}

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol?, networkService: NetworkServiceProtocol, character: Character?)
    func setDetailCharacter()
}

final class DetailPresenter: DetailPresenterProtocol {
    weak var view: DetailViewProtocol?
    var networkService: NetworkServiceProtocol
    var character: Character?

    required init(view: DetailViewProtocol?, networkService: NetworkServiceProtocol, character: Character?) {
        self.view = view
        self.networkService = networkService
        self.character = character
    }

    func setDetailCharacter() {
        self.view?.setDetailCharacter(character)
    }
}
