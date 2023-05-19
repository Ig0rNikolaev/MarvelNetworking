//
//  BuilderDetail.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 16.03.2023.
//

import UIKit

final class BuilderDetail {
    static func build(character: Character) -> UIViewController {
        let view = DetailCharacterView()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, character: character)
        view.presenter = presenter
        return view
    }
}
