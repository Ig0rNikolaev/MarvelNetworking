//
//  ViewController.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 08.03.2023.
//
import Foundation

struct CharacterData: Codable {
    var data: CharacterStorage?
}

struct CharacterStorage: Codable {
    var results: [Character]?
}

struct Character: Codable {
    let name: String?
    let description: String?
    let thumbnail: Image?
    let resourceURI: String?
}

struct Image: Codable {
    let path: String?
    let imageExtension: String?

    enum CodingKeys: String, CodingKey {
        case path = "path"
        case imageExtension = "extension"
    }

    var url: String {
        if let path = path, let imageExt = imageExtension {
            return path + "/standard_fantastic." + imageExt
        }
        return ""
    }
}
