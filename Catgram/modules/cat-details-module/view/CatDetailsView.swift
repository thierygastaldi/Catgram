//
//  CatDetailsView.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

class CatDetailsView: UIViewController {
    var presenter: CatDetailsPresenterProtocol?
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
}

extension CatDetailsView: CatDetailsViewProtocol {
    func showCatDetails(with catInfo: CatInfo) {
        loadingView.stopAnimating()
    }
}
