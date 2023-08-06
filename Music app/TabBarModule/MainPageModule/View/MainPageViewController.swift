//
//  MainPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 5.08.23.
//

import UIKit

class MainPageViewController: UIViewController {

    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        let headerNib = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "HeaderTableViewCell")
        let suggestedNib = UINib(nibName: "SuggestedPlaylistTableViewCell", bundle: nil)
        tableView.register(suggestedNib, forCellReuseIdentifier: "SuggestedPlaylistTableViewCell")
    }


}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell else { return UITableViewCell() }
        guard let suggestedCell = tableView.dequeueReusableCell(withIdentifier: "SuggestedPlaylistTableViewCell") as? SuggestedPlaylistTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
            case 0:
                return headerCell
            case 1:
                return suggestedCell
            default:
                return headerCell
        }
    }
    
    
}
