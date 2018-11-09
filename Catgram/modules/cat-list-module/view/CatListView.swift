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
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.groupTableViewBackground
        
        tableView.register(UINib(nibName: "CatTableViewCell", bundle: nil), forCellReuseIdentifier: "CatTableViewCell")
    }
}

extension CatListView: CatListViewProtocol {
    func showCatList(with catList: [CatInfo]) {
        self.catList = catList
        loadingView.stopAnimating()
        tableView.reloadData()
    }
}

extension CatListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatTableViewCell") as! CatTableViewCell
        let catInfo = catList[indexPath.row]
        cell.set(catInfo: catInfo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let catInfo = catList[indexPath.row]
        presenter?.showCatDetails(with: catInfo)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
}


