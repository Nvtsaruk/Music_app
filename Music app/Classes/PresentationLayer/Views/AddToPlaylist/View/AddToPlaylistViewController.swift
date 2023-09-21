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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        let tablePlaylistNib = UINib(nibName: "MyPlaylistTableViewCell", bundle: nil)
        tableView.register(tablePlaylistNib, forCellReuseIdentifier: "MyPlaylistTableViewCell")
        readyButtonOutlet.layer.cornerRadius = readyButtonOutlet.frame.height / 2
        createPlaylistButtonOutlet.layer.cornerRadius = createPlaylistButtonOutlet.frame.height / 2
    }
    
    @IBAction func createPlaylistButtonAction(_ sender: Any) {
    }
    @IBAction func readyButtonAction(_ sender: Any) {
        print("Wokring")
    }
    
}

extension AddToPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tablePlaylistCell = tableView.dequeueReusableCell(withIdentifier: "MyPlaylistTableViewCell") as? MyPlaylistTableViewCell else { return UITableViewCell()}
//        tablePlaylistCell.configure(playlist: "Test", imageUrl: "")
        return tablePlaylistCell
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
