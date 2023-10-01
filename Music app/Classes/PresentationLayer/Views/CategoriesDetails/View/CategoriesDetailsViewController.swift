import UIKit
final class CategoriesDetailsViewController: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
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
        if viewModel?.isLoading == true {
            loadingIndicator.startAnimating()
        }
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
            loadingIndicator.stopAnimating()
            collectionView.reloadData()
        }
    }
}

extension CategoriesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
