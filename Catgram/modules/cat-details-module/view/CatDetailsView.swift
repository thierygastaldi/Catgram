//
//  CatDetailsView.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CatDetailsView: UIViewController {
    var presenter: CatDetailsPresenterProtocol?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    @objc func reloadData(_ sender: UITapGestureRecognizer) {
        loadingView.startAnimating()
        errorView.isHidden = true
        presenter?.reloadData()
    }
    
    func showReloadOption() {
        loadingView.stopAnimating()
        errorView.isHidden = false
        
        errorLabel.text = "Try again"
        errorImageView.image = UIImage(named: "iconeRecarregar")
        errorImageView.image = errorImageView.image!.withRenderingMode(.alwaysTemplate)
        errorImageView.tintColor = UIColor.darkGray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.reloadData(_:)))
        errorImageView.addGestureRecognizer(tapGesture)
        errorImageView.isUserInteractionEnabled = true
    }
}

extension CatDetailsView: CatDetailsViewProtocol {
    func showCatDetails(with catInfo: CatInfo) {
        
        // Show image
        let url = URL(string: catInfo.url!)
        photoImageView.kf.setImage(with: url, completionHandler: {
            (image, error, cacheType, imageUrl) in
            self.loadingView.stopAnimating()
        })
    }
}
