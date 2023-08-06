//
//  SuggestedPlaylistTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit

final class SuggestedPlaylistTableViewCell: UITableViewCell {

    //MARK: -IBOutlet
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setupUI()
        
    }
    
    private func setupUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let collectionNib = UINib(nibName: "SuggestePlaylistCollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "SuggestePlaylistCollectionViewCell")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SuggestedPlaylistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestePlaylistCollectionViewCell", for: indexPath) as? SuggestePlaylistCollectionViewCell else { return UICollectionViewCell()}
        return cell
    }
    
    
}
