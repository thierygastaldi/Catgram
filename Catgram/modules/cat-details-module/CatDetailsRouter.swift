//
//  CatDetailsRouter.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 08/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

class CatDetailsRouter: CatDetailsRouterProtocol {
    static func createCatDetailsModule(with catInfo: CatInfo) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "CatDetailsView")
        if let view = viewController as? CatDetailsView {
            let interactor: CatDetailsInteractorInputProtocol = CatDetailsInteractor()
            let presenter: CatDetailsPresenterProtocol & CatDetailsInteractorOutputProtocol = CatDetailsPresenter()
            let router: CatDetailsRouterProtocol = CatDetailsRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.catInfo = catInfo
            interactor.presenter = presenter
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
