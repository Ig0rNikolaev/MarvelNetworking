//
//  ViewController.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 08.03.2023.
//

struct CharacterData: Decodable {
    var data: CharacterStorage?
}

struct CharacterStorage: Decodable {
    var results: [Character]?
}

struct Character: Decodable {
    let name: String?
    let description: String?
    let thumbnail: Image?
    let resourceURI: String?
    let comics: ComicList?
}

struct Image: Decodable {
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

struct ComicList: Decodable {
    let items: [ComicSummary]?
}

struct ComicSummary: Decodable {
    let resourceURI: String?
    let name: String?
}
