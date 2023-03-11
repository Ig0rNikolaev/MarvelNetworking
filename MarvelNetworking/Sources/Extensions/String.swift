//
//  Extensions.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import Foundation
import CryptoKit

extension String {
   static func md5(_ source: String) -> String {
        return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
