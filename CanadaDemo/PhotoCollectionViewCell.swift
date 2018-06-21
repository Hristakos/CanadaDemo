//
//  PhotoCollectionViewCell.swift
//  CanadaDemo
//
//  Created by Peter Hristakos on 21/6/18.
//  Copyright © 2018 Peter Hristakos. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
  
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
 
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        print("image name \(image.description)")
                        print("image width = \(image.size.width)")
                        print("image height = \(image.size.height)")
                    }
                }
            }
        }
    
    }
}

