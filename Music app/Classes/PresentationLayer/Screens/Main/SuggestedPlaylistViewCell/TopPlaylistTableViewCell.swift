import UIKit
import SDWebImage

final class TopPlaylistTableViewCell: UITableViewCell {
    //MARK: -IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: -Variables
    weak var delegate: ViewDelegate?
    var numRows = 0
    var collectionData: Toplist? {
        didSet{
            self.collectionView.reloadData()
            self.delegate?.reloadTableView()
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
        let collectionNib = UINib(nibName: XibNames.topPlaylistCollectionViewCell.name, bundle: nil)
        collectionView.register(collectionNib, forCellWithReuseIdentifier: XibNames.topPlaylistCollectionViewCell.name)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TopPlaylistTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XibNames.topPlaylistCollectionViewCell.name, for: indexPath) as? TopPlaylistCollectionViewCell else { return UICollectionViewCell()}
        let url = collectionData?.playlists.items[indexPath.row].images[0].url
        guard let text = collectionData?.playlists.items[indexPath.row].name else { return cell }
        cell.configure(title: text, imageUrl: url ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showItemDetail(id: collectionData?.playlists.items[indexPath.row].id ?? "")
    }
}

extension TopPlaylistTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 2
        let height = (collectionView.frame.height / 3) - 3
        return CGSize(width: width, height: height)
    }
}
