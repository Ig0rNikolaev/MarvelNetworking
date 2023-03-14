//
//  Extensions.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 09.03.2023.
//

import CryptoKit
import UIKit

//: MARK: - String

extension String {
   static func md5(_ source: String) -> String {
        return Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}

//: MARK: - UITextField

extension UITextField {
    func setupLeftImage(imageName: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .white
    }
}
