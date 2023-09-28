//
//  CategoriesDetailsViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 11.09.23.
//

import UIKit

class CategoriesDetailsViewController: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: - Variables
    var viewModel: CategoriesDetailsViewModelProtocol?
    var numRows: Int = 0
    
    var collectionData: Toplist? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = viewModel?.name
        let collectionNib = UINib(nibName: "PlaylistsCollectionViewCell", bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: "PlaylistsCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            self.numRows = viewModel?.playlists?.playlists.items.count ?? 0
            self.collectionData = viewModel?.playlists
        }
    }
}

extension CategoriesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as? PlaylistsCollectionViewCell else { return UICollectionViewCell()}
        cell.descriptionLabel.text = collectionData?.playlists.items[indexPath.row].description
        guard let url = collectionData?.playlists.items[indexPath.row].images[0].url else { return cell }
        cell.imageView.webImage(url: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.showItemDetail(id: collectionData?.playlists.items[indexPath.row].id ?? "")
    }
    
    
}
extension CategoriesDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height / 3) - 1
        let width = (collectionView.frame.width / 2) - 1
        return CGSize(width: width, height: height)

    }

}

extension CategoriesDetailsViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .CategoriesDetails
    }
}
