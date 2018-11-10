//
//  CatListProtocols.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

protocol CatListViewProtocol: class {
    var presenter: CatListPresenterProtocol? { get set }
    
    func showCatList(with catList: [CatInfo])
    func showEmptyListMessage()
    func showReloadOption()
}

protocol CatListRouterProtocol: class {
    static func createCatListModule() -> UIViewController
    
    func pushCatDetailsModule(from view: CatListViewProtocol, with catInfo: CatInfo)
    func showAlertView(from view: CatListViewProtocol, withTitle title: String, andMessage message: String)
}

protocol CatListInteractorInputProtocol: class {
    var presenter: CatListInteractorOutputProtocol? { get set }
    
    func retrieveCatList()
}

protocol CatListInteractorOutputProtocol: class {
    func didRetrieveCatListSuccess(catList: [CatInfo])
    func onError(with message:String)
}

protocol CatListPresenterProtocol: class {
    var view: CatListViewProtocol? { get set }
    var interactor: CatListInteractorInputProtocol? { get set }
    var router: CatListRouterProtocol? { get set }
    
    func viewDidLoad()
    func showCatDetails(with catInfo: CatInfo)
    func reloadData()
}
