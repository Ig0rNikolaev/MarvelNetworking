//
//  Builder.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 10.03.2023.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    func createView() -> UIViewController
    static func createView(character: Character) -> UIViewController
}

class Builder: BuilderProtocol {
    func createView() -> UIViewController {
        let view = CharacterTabelView()
        let networkService = NetworkService()
        let presenter = CharacterPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }

   static func createView(character: Character) -> UIViewController {
        let view = DetailCharacterView()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkServise: networkService, character: character)
        view.presenter = presenter
        return view
    }
}
