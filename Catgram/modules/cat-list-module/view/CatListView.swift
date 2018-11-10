//
//  CatListView.swift
//  Catgram
//
//  Created by Thiery Gastaldi on 07/11/2018.
//  Copyright © 2018 TGR. All rights reserved.
//

import Foundation
import UIKit

class CatListView: UIViewController {
    
    var presenter: CatListPresenterProtocol?
    var catList: [CatInfo] = []
    var favoriteCatList: [CatInfo] = []
    var favoriteMode: Bool = false
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        // Register nib cell
        tableView.register(UINib(nibName: "CatTableViewCell", bundle: nil), forCellReuseIdentifier: "CatTableViewCell")
    }
    
    @objc func reloadData(_ sender: UITapGestureRecognizer) {
        loadingView.startAnimating()
        tableView.isHidden = false
        presenter?.reloadData()
    }
    
    // Hide tableview and show reload button
    func showErrorViewWith(message: String) {
        tableView.isHidden = true
        loadingView.stopAnimating()
        
        errorLabel.text = message
        errorImageView.image = UIImage(named: "iconeRecarregar")
        errorImageView.image = errorImageView.image!.withRenderingMode(.alwaysTemplate)
        errorImageView.tintColor = UIColor.darkGray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.reloadData(_:)))
        errorImageView.addGestureRecognizer(tapGesture)
        errorImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            favoriteMode = false
        case 1:
            favoriteMode = true
        default:
            break
        }
        tableView.reloadData()
    }
    
}

extension CatListView: CatListViewProtocol {
    func showCatList(with catList: [CatInfo]) {
        self.catList = catList
        loadingView.stopAnimating()
        tableView.reloadData()
    }
    
    func showEmptyListMessage() {
        showErrorViewWith(message: "Sorry, empty list!")
    }
    
    func showReloadOption() {
        showErrorViewWith(message: "Try again")
    }
}

extension CatListView: CatTableViewCellDelegate {
    func didLikeImage(catInfo: CatInfo) {
        if catInfo.hasLike! {
            favoriteCatList.insert(catInfo, at: 0)
        }
        else {
            favoriteCatList = favoriteCatList.filter( { $0.id != catInfo.id } )
        }
        
        // Reload view to remove unliked itens
        if favoriteMode {
            tableView.reloadData()
        }
    }
}

extension CatListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favoriteMode {
            return favoriteCatList.count
        }
        else {
            return catList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell") as! CatTableViewCell
        
        var catInfo: CatInfo!
        if favoriteMode {
            catInfo = favoriteCatList[indexPath.row]
        }
        else {
            catInfo = catList[indexPath.row]
        }
        
        // Config cell
        cell.set(catInfo: catInfo)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var catInfo: CatInfo!
        if favoriteMode {
            catInfo = favoriteCatList[indexPath.row]
        }
        else {
            catInfo = catList[indexPath.row]
        }
        
        presenter?.showCatDetails(with: catInfo)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
}


