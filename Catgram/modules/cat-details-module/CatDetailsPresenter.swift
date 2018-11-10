//
//  CatDetailsPresenter.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation

class CatDetailsPresenter: CatDetailsPresenterProtocol {
    var view: CatDetailsViewProtocol?
    var interactor: CatDetailsInteractorInputProtocol?
    var router: CatDetailsRouterProtocol?
    var catInfo: CatInfo?
    
    func viewDidLoad() {
        interactor?.retrieveCatDetails(with: catInfo!)
    }
    
    func reloadData() {
        interactor?.retrieveCatDetails(with: catInfo!)
    }
}

extension CatDetailsPresenter: CatDetailsInteractorOutputProtocol {
    func didRetrieveCatDetailsSuccess(with catInfo: CatInfo) {
        view?.showCatDetails(with: catInfo)
    }
    
    func onError(with message: String) {
        view?.showReloadOption()
        router?.showAlertView(from: view!, withTitle: "Error", andMessage: message)
    }
}
