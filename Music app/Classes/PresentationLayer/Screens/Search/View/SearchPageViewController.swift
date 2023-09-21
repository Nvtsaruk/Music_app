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
    var viewModel: SearchPageViewModelProtocol?
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
        let tablePlaylistNib = UINib(nibName: "PlaylistTableViewCell", bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: "PlaylistTableViewCell")
        let tableArtistNib = UINib(nibName: "ArtistTableViewCell", bundle: nil)
        tableView.register(tableArtistNib, forCellReuseIdentifier: "ArtistTableViewCell")
        let tableTrackNib = UINib(nibName: "TrackItemDetailTableViewCell", bundle: nil)
        tableView.register(tableTrackNib, forCellReuseIdentifier: "TrackItemDetailTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            //            self.numRows = viewModel?.categories?.categories.items.count ?? 0
            tableView.reloadData()
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
        4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                return viewModel?.searchModel.artists.items.count ?? 0
            case 1:
                return viewModel?.searchModel.tracks.items.count ?? 0
            case 2:
                return viewModel?.searchModel.playlists.items.count ?? 0
            default:
                return viewModel?.searchModel.albums.items.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableAlbumCell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell else { return UITableViewCell()}
        guard let tableArtistCell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableViewCell") as? ArtistTableViewCell else {
            return UITableViewCell()}
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell") as? PlaylistTableViewCell else { return UITableViewCell()}
        guard let tableTrackCell = tableView.dequeueReusableCell(withIdentifier: "TrackItemDetailTableViewCell") as? TrackItemDetailTableViewCell else { return UITableViewCell()}
        guard let albumCount = viewModel?.searchModel.artists.items.count else { return UITableViewCell() }
        if indexPath.row < albumCount - 1 {
            if viewModel?.searchModel.albums.items[indexPath.row].type == "album" {
                guard let imageUrl = viewModel?.searchModel.albums.items[indexPath.row].images?.first?.url,
                      let album = viewModel?.searchModel.albums.items[indexPath.row].name,
                      let artist = viewModel?.searchModel.albums.items[indexPath.row].artists.first?.name
                else { return UITableViewCell()}
                tableAlbumCell.configure(artist: artist, album: album, imageUrl: imageUrl)
            }
        }
        guard let artistCount = viewModel?.searchModel.artists.items.count else { return UITableViewCell() }
        if indexPath.row < artistCount - 1 {
            if viewModel?.searchModel.artists.items[indexPath.row].type == "artist" {
                let imageUrl = viewModel?.searchModel.artists.items[indexPath.row].images?.first?.url
                guard let artist = viewModel?.searchModel.artists.items[indexPath.row].name
                else { return UITableViewCell()}
                tableArtistCell.configure(name: artist, image: imageUrl)
            }
        }
        guard let playlistCount = viewModel?.searchModel.playlists.items.count else { return UITableViewCell() }
        if indexPath.row < playlistCount - 1 {
            if viewModel?.searchModel.playlists.items[indexPath.row].type == "playlist" {
                guard let imageUrl = viewModel?.searchModel.playlists.items[indexPath.row].images?.first?.url,
                      let playlist = viewModel?.searchModel.playlists.items[indexPath.row].name
                else { return UITableViewCell()}
                tablePlaylistCell.configure(playlist: playlist, imageUrl: imageUrl)
            }
        }
        guard let trackCount = viewModel?.searchModel.tracks.items.count else { return UITableViewCell() }
        if indexPath.row < trackCount - 1 {
            if viewModel?.searchModel.tracks.items.count != 0 {
                if viewModel?.searchModel.tracks.items[indexPath.row].type == "track" {
                    guard let imageUrl = viewModel?.searchModel.tracks.items[indexPath.row].album.images?.first?.url,
                          let track = viewModel?.searchModel.tracks.items[indexPath.row].name,
                          let artist = viewModel?.searchModel.tracks.items[indexPath.row].artists.first?.name
                    else { return UITableViewCell()}
                    tableTrackCell.configure(track: track, artist: artist, image: imageUrl)
                }
            }
        }
        
        switch indexPath.section {
            case 0:
                return tableArtistCell
            case 1:
                return tableTrackCell
            case 2:
                return tablePlaylistCell
            default:
                return tableAlbumCell
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
    //        let header = view as! UITableViewHeaderFooterView
    //        header.textLabel?.textColor = UIColor.white
    //        header.textLabel?.text = header.textLabel!.text!.capitalized
    //    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Artist"
            case 1:
                return "Track"
            case 2:
                return "Playlist"
            default:
                return "Album"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "TrackItemDetailTableViewCell" {
            guard let previewURL = viewModel?.searchModel.tracks.items[indexPath.row].preview_url,
                  let image = viewModel?.searchModel.tracks.items[indexPath.row].album.images?.first?.url,
                  let track = viewModel?.searchModel.tracks.items[indexPath.row].name,
                  let artist = viewModel?.searchModel.tracks.items[indexPath.row].artists.first?.name
            else { return }
            AudioPlayerService.shared.addPlaylistForPlayer([PlayerItemModel(url: previewURL, image: image, trackName: track, artistName: artist)], itemIndex: 0)
        }
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "PlaylistTableViewCell" {
            guard let id = viewModel?.searchModel.playlists.items[indexPath.row].id else { return }
            viewModel?.showPlaylistDetail(id: id)
        }
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "ArtistTableViewCell" {
            guard let id = viewModel?.searchModel.artists.items[indexPath.row].id else { return }
            viewModel?.showArtistDetail(id: id)
        }
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "AlbumTableViewCell" {
            guard let id = viewModel?.searchModel.albums.items[indexPath.row].id else { return }
            viewModel?.showAlbumDetail(id: id)
        }
    }
//    func getTrackUrl(id: String) {
//        let url = "https://api.spotify.com/v1/tracks/\(id)"
//        APIService.getData(Track.self, url: url) { result in
//            switch result {
//                case .success(let data):
//                    print(data.album?.images?.first)
//                case .failure(let error):
//                    print("Custom Error -> \(error)")
//            }
//        }
//    }
}

extension SearchPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .SearchPage
    }
}
