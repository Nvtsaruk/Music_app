//
//  AddToPlaylistViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 21.09.23.
//

import UIKit

final class AddToPlaylistViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var readyButtonOutlet: UIButton!
    @IBOutlet weak var createPlaylistButtonOutlet: UIButton!
    
    var viewModel: AddToPlaylistViewModelProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.start()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let tablePlaylistNib = UINib(nibName: "MyPlaylistTableViewCell", bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: "MyPlaylistTableViewCell")
        readyButtonOutlet.layer.cornerRadius = readyButtonOutlet.frame.height / 2
        createPlaylistButtonOutlet.layer.cornerRadius = createPlaylistButtonOutlet.frame.height / 2
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            
            tableView.reloadData()
            
        }
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        viewModel?.cancel()
    }
    @IBAction func createPlaylistButtonAction(_ sender: Any) {
        viewModel?.createPlaylist(playlistName: "First")
    }
    @IBAction func readyButtonAction(_ sender: Any) {
        
    }
    
}

extension AddToPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.playlist.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: "MyPlaylistTableViewCell") as? MyPlaylistTableViewCell else { return UITableViewCell()}
        guard let numTracks = viewModel?.playlist[indexPath.row].tracks.count,
              let name = viewModel?.playlist[indexPath.row].playlistName,
              let image = viewModel?.playlist[indexPath.row].tracks.first?.image
        else { return tablePlaylistCell}
        tablePlaylistCell.configure(numTracks: String(numTracks), name: name, image: image)
        return tablePlaylistCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectedPlaylist(id: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    
    
}

extension AddToPlaylistViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .AddToPlaylist
    }
}

#Preview {
    let vc = AddToPlaylistViewController.instantiate()
    return vc
}
