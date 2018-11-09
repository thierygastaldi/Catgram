//
//  CatTableViewCell.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    func set(catInfo: CatInfo) {
        self.selectionStyle = .none
        
        // Title code label
        titleLabel.text = String.localizedStringWithFormat("#%@", catInfo.id!)
        
        // Download image
        let url = URL(string: catInfo.url!)
        photoImageView.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.loadingView.stopAnimating()
        })
        
        // Config LikeImage button
        likeImageView.image = UIImage(named: "iconeCurtir")
        likeImageView.image = likeImageView.image!.withRenderingMode(.alwaysTemplate)
        likeImageView.tintColor = Layout.mainColor
        
        // Add tap gesture on likeImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeImage(_:)))
        likeImageView.addGestureRecognizer(tapGesture)
        likeImageView.isUserInteractionEnabled = true
    }
    
    @objc func likeImage(_ sender: UITapGestureRecognizer) {
        
    }
    
}
