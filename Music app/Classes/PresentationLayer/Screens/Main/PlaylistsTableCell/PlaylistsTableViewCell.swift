import UIKit
final class PlaylistsTableViewCell: UITableViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Variables
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
    }
}

extension PlaylistsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaylistsCollectionViewCell", for: indexPath) as? PlaylistsCollectionViewCell else { return UICollectionViewCell()}
        guard let description = collectionData?.playlists.items[indexPath.row].description,
              let url = collectionData?.playlists.items[indexPath.row].images[0].url
        else { return cell }
        cell.configure(description: description, imageUrl: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showItemDetail(id: collectionData?.playlists.items[indexPath.row].id ?? "")
    }
}

extension PlaylistsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height)
        return CGSize(width: 130, height: height)
    }
}
