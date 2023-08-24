//
//  SearchPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import UIKit

class SearchPageViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var viewModel: SearchPageViewModel?
    
    var numRows: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
//            self.numRows = viewModel?.searchModel.albums.items.count ?? 0
        }
    }
}


extension SearchPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(item: searchText)
    }
}

extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension SearchPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .SearchPage
    }
    
    
}
