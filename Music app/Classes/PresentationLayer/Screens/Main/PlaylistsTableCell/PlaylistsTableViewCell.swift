//
//  PlaylistsTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 21.08.23.
//

import UIKit

class PlaylistsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ViewDelegate?
    
    var numRows = 0 
    
    var collectionData: Toplist? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        let collectionNib = UINib(nibName: "PlaylistsCollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension PlaylistsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as? PlaylistsCollectionViewCell else { return UICollectionViewCell()}
        cell.descriptionLabel.text = collectionData?.playlists?.items?[indexPath.row].description
        guard let url = collectionData?.playlists?.items?[indexPath.row].images?[0].url else { return cell }
        cell.imageView.webImage(url: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showItemDetail(id: collectionData?.playlists?.items?[indexPath.row].id ?? "")
    }
    
    
}
extension PlaylistsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height)
        return CGSize(width: 130, height: height)
    }
}
