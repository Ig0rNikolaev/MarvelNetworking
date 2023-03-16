//
//  File1.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 16.03.2023.
//

import UIKit

extension UITextField {
    func setupLeftImage(imageName: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: imageName)
        let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageContainerView.addSubview(imageView)
        leftView = imageContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
