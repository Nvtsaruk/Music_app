//
//  SuggestedPlaylistTableViewCell.swift
//  Music app
//
//  Created by Tsaruk Nick on 6.08.23.
//

import UIKit
import SDWebImage

final class TopPlaylistTableViewCell: UITableViewCell {

    //MARK: -IBOutlet
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ViewDelegate?
    
    var numRows = 0 {
        didSet {
            collectionView.reloadData()
            self.delegate?.reloadTableView()
//            print("Collection view reload in numrows")
        }
    }
    var collectionData: Toplist? {
        didSet{
//            guard let url = URL(string: collectionData?.albums.items[0].images?[0].url ?? "") else { return}
//            DispatchQueue.main.async {
                self.collectionView.reloadData()
            self.delegate?.reloadTableView()
//            print("Collection view reload")
//            }

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
        
        let collectionNib = UINib(nibName: "TopPlaylistCollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "TopPlaylistCollectionViewCell")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TopPlaylistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        2
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopPlaylistCollectionViewCell", for: indexPath) as? TopPlaylistCollectionViewCell else { return UICollectionViewCell()}
        cell.playlistTitle.text = collectionData?.playlists?.items?[indexPath.row].name
        cell.totalTracksLabel.text = String(collectionData?.playlists?.items?[indexPath.row].tracks?.total ?? 0)
        guard let url = collectionData?.playlists?.items?[indexPath.row].images?[0].url ?? URL(string: "") else { return cell }
        cell.playlistImage.sd_setImage(with: url, placeholderImage: .checkmark)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showItemDetail(id: collectionData?.playlists?.items?[indexPath.row].id ?? "")
    }
}

extension TopPlaylistTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 2
        let height = (collectionView.frame.height / 3) - 3
        return CGSize(width: width, height: height)
    }
}
