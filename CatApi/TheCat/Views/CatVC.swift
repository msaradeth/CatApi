//
//  TheCatVC.swift
//  CatApi
//
//  Created by Mike Saradeth on 3/16/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//
//class CatTableViewCell: UITableViewCell {
//    static let CellIdentifier = "Cell"

import UIKit
import RxSwift
import RxCocoa

class CatVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedCntrl: UISegmentedControl!
    
    fileprivate let disposeBag = DisposeBag()
    var viewModel: CatViewModel!
    
    // Inject need objects for this view controller
    static func createWith(title: String, viewModel: CatViewModel) -> CatVC {
        let vc = UIStoryboard.createWith(storyBoard: "Main", withIdentifier: "CatVC") as! CatVC
        vc.title = title
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        viewModel.loadData()
    }
    
    @IBAction func segCntrlAction(_ sender: UISegmentedControl) {
        let catType = CatType.getType(segmentIndex: sender.selectedSegmentIndex)
        viewModel.currCatType = catType
    }
    
    func setupRx() {
        tableView.register(UINib(nibName: "CatTableViewCell", bundle: nil), forCellReuseIdentifier: CatTableViewCell.identifier)
        
        viewModel.subject.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CatTableViewCell.identifier, cellType: CatTableViewCell.self)) { [weak self] (row, item, cell) in
                guard let this = self else { return }
                cell.configure(item: item, index: row, toggleFavorite: this.viewModel)
            }
            .disposed(by: disposeBag)
    }
}

