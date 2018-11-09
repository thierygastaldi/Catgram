//
//  CatListRouter.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

class CatListRouter: CatListRouterProtocol {
    static func createCatListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "CatNavigationController")
        if let view = navController.childViewControllers.first as? CatListView {
            let interactor: CatListInteractorInputProtocol = CatListInteractor()
            let presenter: CatListPresenterProtocol & CatListInteractorOutputProtocol = CatListPresenter()
            let router: CatListRouterProtocol = CatListRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            interactor.presenter = presenter
            
            return navController
        }
        return UIViewController()
    }
    
    func pushCatDetailsModule(from view: CatListViewProtocol, with catInfo: CatInfo) {
        let catDetailsModule = CatDetailsRouter.createCatDetailsModule(with: catInfo)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(catDetailsModule, animated: true)
        }
    }
    
    func showAlertView(from view: CatListViewProtocol, withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        if let sourceView = view as? UIViewController {
            sourceView.present(alert, animated: true, completion: nil)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
