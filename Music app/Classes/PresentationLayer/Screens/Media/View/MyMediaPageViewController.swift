//
//  MyMediaPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import UIKit

class MyMediaPageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
   
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var viewModel: MyMediaPageViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let tablePlaylistNib = UINib(nibName: "PlaylistTableViewCell", bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: "PlaylistTableViewCell")
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            tableView.reloadData()
        }
    }

    
}

extension MyMediaPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.databasePlaylist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell") as? PlaylistTableViewCell else { return UITableViewCell()}
        guard let name = viewModel?.databasePlaylist[indexPath.row].playlistName,
              let image = viewModel?.databasePlaylist[indexPath.row].tracks.first?.image
        else { return tablePlaylistCell}
        tablePlaylistCell.configure(playlist: name, imageUrl: image)
        return tablePlaylistCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showPlaylist(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}

extension MyMediaPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        return .MyMediaPage
    }
    
    
}
