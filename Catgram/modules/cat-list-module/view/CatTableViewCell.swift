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

protocol CatTableViewCellDelegate {
    func didLikeImage(catInfo: CatInfo)
}

class CatTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var actionLikeBlock: (() -> Void)? = nil
    var catInfo: CatInfo!
    var delegate: CatTableViewCellDelegate?
    
    func set(catInfo: CatInfo) {
        self.selectionStyle = .none
        self.catInfo = catInfo
        
        // Set title code label
        titleLabel.text = String.localizedStringWithFormat("#%@", catInfo.id!)
        
        // Show image
        let url = URL(string: catInfo.url!)
        photoImageView.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.loadingView.stopAnimating()
        })
        
        // Config LikeImage button
        configLikeImage()
        
        // Add tap gesture on likeImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeImage(_:)))
        likeImageView.addGestureRecognizer(tapGesture)
        likeImageView.isUserInteractionEnabled = true
    }
    
    @objc func likeImage(_ sender: UITapGestureRecognizer) {
        catInfo.hasLike = !catInfo.hasLike!
        configLikeImage()
        delegate?.didLikeImage(catInfo: catInfo)
    }
    
    func configLikeImage() {
        if catInfo.hasLike! {
            likeImageView.image = UIImage(named: "iconeCurtirSelecionado")
            likeImageView.image = likeImageView.image!.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = Layout.mainColor
        }
        else {
            likeImageView.image = UIImage(named: "iconeCurtir")
            likeImageView.image = likeImageView.image!.withRenderingMode(.alwaysTemplate)
            likeImageView.tintColor = Layout.mainColor
        }
    }
    
}
