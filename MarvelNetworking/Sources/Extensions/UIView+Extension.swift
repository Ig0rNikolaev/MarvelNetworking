//
//  UIView+Extension.swift
//  MarvelNetworking
//
//  Created by Игорь Николаев on 19.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
