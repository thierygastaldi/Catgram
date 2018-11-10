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
    
    func reloadData() {
        interactor?.retrieveCatList()
    }
}

extension CatListPresenter: CatListInteractorOutputProtocol {
    func didRetrieveCatListSuccess(catList: [CatInfo]) {
        if catList.count > 0 {
            view?.showCatList(with: catList)
        }
        else {
            view?.showEmptyListMessage()
        }
    }
    
    func onError(with message: String) {
        view?.showReloadOption()
        router?.showAlertView(from: view!, withTitle: "Error", andMessage: message)
    }
}
