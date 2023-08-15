//
//  SuggestedPlaylistTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit
import SDWebImage

final class SuggestedPlaylistTableViewCell: UITableViewCell {

    //MARK: -IBOutlet
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var numRows = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    var collectionData: NewReleases? {
        didSet{
            print("here")
            guard let url = URL(string: collectionData?.albums.items[0].images[0].url ?? "") else { return}
            print(url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        self.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let collectionNib = UINib(nibName: "SuggestedPlaylistCollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "SuggestedPlaylistCollectionViewCell")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SuggestedPlaylistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        2
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestedPlaylistCollectionViewCell", for: indexPath) as? SuggestedPlaylistCollectionViewCell else { return UICollectionViewCell()}
        cell.playlistTitle.text = collectionData?.albums.items[indexPath.row].name
        guard let url = URL(string: collectionData?.albums.items[indexPath.row].images[0].url ?? "") else { return cell }
        print(url)
        cell.playlistImage.sd_setImage(with: url, placeholderImage: .checkmark)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SuggestedPlaylistTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 3
        let height = (collectionView.frame.height / 3) - 6
        return CGSize(width: width, height: height)
    }
}
