//
//  SearchPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 7.09.23.
//

import UIKit

class SearchPageViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: SearchPageViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        searchBar.searchTextField.textColor = .white
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        let tableAlbumNib = UINib(nibName: "AlbumTableViewCell", bundle: nil)
        tableView.register(tableAlbumNib, forCellReuseIdentifier: "AlbumTableViewCell")
        let tableArtistNib = UINib(nibName: "ArtistTableViewCell", bundle: nil)
        tableView.register(tableArtistNib, forCellReuseIdentifier: "ArtistTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            //            self.numRows = viewModel?.categories?.categories.items.count ?? 0
            tableView.reloadData()
            print("In closure", self.viewModel?.searchModel.albums.items.count)
        }
    }
}
extension SearchPageViewController: UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        viewModel?.backToSearchCategories()
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(item: searchText)
    }
}

extension SearchPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return viewModel?.searchModel.artists.items.count ?? 0
            default:
                return viewModel?.searchModel.albums.items.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableAlbumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell else { return UITableViewCell()}
        guard let tableArtistCell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell") as? ArtistTableViewCell else {
            return UITableViewCell()}
        if viewModel?.searchModel.albums.items[indexPath.row].type == "album" {
            guard let imageUrl = viewModel?.searchModel.albums.items[indexPath.row].images?.first?.url,
                  let album = viewModel?.searchModel.albums.items[indexPath.row].name,
                  let artist = viewModel?.searchModel.albums.items[indexPath.row].artists.first?.name
            else { return UITableViewCell()}
            tableAlbumCell.configure(artist: artist, album: album, imageUrl: imageUrl)
        }
        if viewModel?.searchModel.artists.items[indexPath.row].type == "artist" {
            let imageUrl = viewModel?.searchModel.artists.items[indexPath.row].images?.first?.url
            guard let artist = viewModel?.searchModel.artists.items[indexPath.row].name
                    
            else { return UITableViewCell()}
            print(artist)
            tableArtistCell.configure(name: artist, image: imageUrl)
        }
        
        switch indexPath.section {
            case 0:
                return tableArtistCell
                //            case 1:
                //                return topPlaylists
            default:
                return tableAlbumCell
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    //        let header = view as! UITableViewHeaderFooterView
    //        header.textLabel?.textColor = UIColor.white
    //        header.textLabel?.text = header.textLabel!.text!.capitalized
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print(viewModel?.searchModel.artists.items[indexPath.row].name)
    }
}

extension SearchPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .SearchPage
    }
}
