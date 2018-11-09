//
//  CatListPresenter.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation

class CatListPresenter: CatListPresenterProtocol {
    var view: CatListViewProtocol?
    var interactor: CatListInteractorInputProtocol?
    var router: CatListRouterProtocol?
    
    func viewDidLoad() {
        interactor?.retrieveCatList()
    }
    
    func showCatDetails(with catInfo: CatInfo) {
        router?.pushCatDetailsModule(from: view!, with: catInfo)
    }
}

extension CatListPresenter: CatListInteractorOutputProtocol {
    func didRetrieveCatListSuccess(catList: [CatInfo]) {
        view?.showCatList(with: catList)
    }
    
    func onError(with message: String) {
        router?.showAlertView(from: view!, withTitle: "Error", andMessage: message)
    }
}
