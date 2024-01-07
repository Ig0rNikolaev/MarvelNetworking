//
//  Builder.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 10.03.2023.
//

import UIKit

final class BuilderCharacter {
    static func build() -> UIViewController {
        let view = CharacterTabelView()
        let networkService = NetworkService()
        let presenter = CharacterPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
