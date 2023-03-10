//
//  NetworkService.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import Alamofire

protocol CreatureURLProtocol {
    func buildURL(scheme: String, host: String, path: String, offset: Int, limit: Int, name: String?) -> URL?
}

protocol CreatureImageURLProtocol {
    func getDataImageСharacter(urlRequest: String?, imageСharacter: UIImageView)
}

protocol NetworkServiceProtocol {
    func getData(name: String?, complition: @escaping (Result<CharacterData?, Error>) -> Void)
}

class CreatureURL: CreatureURLProtocol {
    func buildURL(scheme: String, host: String, path: String, offset: Int, limit: Int, name: String?) -> URL? {

        let publicKey = "8ff288aa4d9bd9b25d051aea9585e041"
        let privateKey = "745eeeff855e804c98b080fd6570b1b2b8553550"
        let ts = Date().timeIntervalSince1970.description
        let hashString = ts + privateKey + publicKey
        let hash = String.md5(hashString)

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
        ]
        if name != nil {
            components.queryItems?.append(URLQueryItem(name: "nameStartsWith", value: name))
        }
        return components.url
    }
}

class NetworkService: NetworkServiceProtocol {
    func getData(name: String?, complition completion: @escaping (Result<CharacterData?, Error>) -> Void) {
        let urlMarvel = CreatureURL()
        guard let url = urlMarvel.buildURL(scheme: "https",
                                           host: "gateway.marvel.com",
                                           path: "/v1/public/characters",
                                           offset: 0,
                                           limit: 100, name: name) else { return }
        AF.request(url).validate().responseDecodable(of: CharacterData.self) { response in
            switch response.result {
            case .success(let marvelCharacter):
                completion(.success(marvelCharacter))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
}

class CreatureImageURL: CreatureImageURLProtocol {
    func getDataImageСharacter(urlRequest: String?, imageСharacter: UIImageView) {
        guard let url = URL(string: urlRequest ?? " ") else { return }
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                if let image = UIImage(data: data) {
                    imageСharacter.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
