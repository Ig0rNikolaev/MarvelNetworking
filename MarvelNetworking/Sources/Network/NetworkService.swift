//
//  NetworkService.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import Alamofire

fileprivate enum Constants {
    static let publicKey = "8ff288aa4d9bd9b25d051aea9585e041"
    static let privateKey = "745eeeff855e804c98b080fd6570b1b2b8553550"
    static let ts = "ts"
    static let apikey = "apikey"
    static let hash = "hash"
    static let limit = "limit"
    static let offset = "offset"
    static let queryItemsName = "nameStartsWith"
    static let scheme = "https"
    static let host = "gateway.marvel.com"
    static let path = "/v1/public/characters"
}

protocol CreatureURLProtocol {
    func buildURL(scheme: String, host: String, path: String, offset: Int, limit: Int, name: String?) -> URL?
}

protocol CreatureImageURLProtocol {
    func getDataImageСharacter(urlRequest: String?, imageСharacter: UIImageView)
}

protocol NetworkServiceProtocol {
    func getData<T: Decodable>(type: T.Type, name: String?, complition: @escaping (Result<T?, Error>) -> Void)
}

final class CreatureURL: CreatureURLProtocol {
    func buildURL(scheme: String, host: String, path: String, offset: Int, limit: Int, name: String?) -> URL? {

        let publicKey = Constants.publicKey
        let privateKey = Constants.privateKey
        let ts = Date().timeIntervalSince1970.description
        let hashString = ts + privateKey + publicKey
        let hash = String.md5(hashString)

        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: Constants.ts, value: ts),
            URLQueryItem(name: Constants.apikey, value: publicKey),
            URLQueryItem(name: Constants.hash, value: hash),
            URLQueryItem(name: Constants.limit, value: String(limit)),
            URLQueryItem(name: Constants.offset, value: String(offset)),
        ]
        if name != nil {
            components.queryItems?.append(URLQueryItem(name: Constants.queryItemsName, value: name))
        }
        return components.url
    }
}

final class NetworkService: NetworkServiceProtocol {
    func getData<T: Decodable>(type: T.Type, name: String?, complition: @escaping (Result<T?, Error>) -> Void) {
        let urlMarvel = CreatureURL()
        guard let url = urlMarvel.buildURL(scheme: Constants.scheme,
                                           host: Constants.host,
                                           path: Constants.path,
                                           offset: 0,
                                           limit: 100, name: name) else { return }
        AF.request(url).validate().responseDecodable(of: (type).self) { response in
            switch response.result {
            case .success(let marvelCharacter):
                complition(.success(marvelCharacter))
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}

final class CreatureImageURL: CreatureImageURLProtocol {
    static let shared = CreatureImageURL(); private init() {}

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
