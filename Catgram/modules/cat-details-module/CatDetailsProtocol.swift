//
//  CatDetailsProtocol.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

protocol CatDetailsViewProtocol: class {
    var presenter: CatDetailsPresenterProtocol? { get set }
    
    func showCatDetails(with catInfo: CatInfo)
}

protocol CatDetailsInteractorInputProtocol: class {
    var presenter: CatDetailsInteractorOutputProtocol? { get set }
    
    func retrieveCatDetails(with catInfo: CatInfo)
}

protocol CatDetailsInteractorOutputProtocol: class {
    func didRetrieveCatDetailsSuccess(with catInfo: CatInfo)
}

protocol CatDetailsRouterProtocol: class {
    static func createCatDetailsModule(with catInfo: CatInfo) -> UIViewController
}

protocol CatDetailsPresenterProtocol: class {
    var view: CatDetailsViewProtocol? { get set }
    var interactor: CatDetailsInteractorInputProtocol? { get set }
    var router: CatDetailsRouterProtocol? { get set }
    var catInfo: CatInfo? { get set }
    
    func viewDidLoad()
}
