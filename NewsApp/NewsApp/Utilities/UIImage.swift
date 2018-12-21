//
//  UIImage.swift
//  NewsApp
//
//  Created by Vaibhav Parmar on 09/11/17.
//  Copyright © 2017 Vaibhav Parmar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(from url: String){
        guard let urlReq = URL(string: url) else { return }
        URLSession.shared.dataTask(with: urlReq) { (imgData, response, error) in
            if error != nil{
                print(error!)
            }
            DispatchQueue.main.async {
                if let data = imgData {
                    self.image = UIImage(data: data)
                }
            }
            }.resume()
    }
}
