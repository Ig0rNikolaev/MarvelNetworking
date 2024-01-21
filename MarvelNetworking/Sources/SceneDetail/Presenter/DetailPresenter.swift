//
//  ModalPresenter.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 13.03.2023.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func setDetailCharacter(_ character: Character?)
}

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol?, networkService: NetworkServiceProtocol, character: Character?)
    func setDetailCharacter(imageСharacter: UIImageView)
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

    func setDetailCharacter(imageСharacter: UIImageView) {
        self.view?.setDetailCharacter(character)
        creatureImageURL(imageСharacter: imageСharacter)
    }

    private func creatureImageURL(imageСharacter: UIImageView) {
         CreatureImageURL.shared.getDataImageСharacter(urlRequest: character?.thumbnail?.url, imageСharacter: imageСharacter)
     }
}
