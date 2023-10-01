import UIKit

final class SearchCategoriesPageViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet private weak var searchCollectionView: UICollectionView!
    
    @IBOutlet private weak var searchContainer: UIView!
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var searchContainerText: UILabel!
    
    //MARK: - Variables
    var viewModel: SearchCategoriesViewModel?
    
    var numRows: Int = 0 {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    private var colors: [UIColor] = [
        .systemPink,
        .systemBlue,
        .systemPurple,
        .systemOrange,
        .systemGreen,
        .systemRed,
        .systemYellow,
        .darkGray,
        .systemTeal
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel?.getCategories()
    }
    
    private func setupUI() {
        if viewModel?.isLoading == true {
            loadingIndicator.startAnimating()
        }
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor.white
        
        searchContainerText.text = SearchPageLocalization.searchbarPlaceholder.string
        
        searchContainer.layer.cornerRadius = 8
        let didTap  = UITapGestureRecognizer(target: self, action: #selector(didTap))
        searchContainer.addGestureRecognizer(didTap)
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        
        let collectionNib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        searchCollectionView.register(collectionNib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
    }
    
    @objc private func didTap() {
        viewModel?.showSearchPage()
    }
    
    private func bindViewModel() {
        viewModel?.updateClosure = { [weak self] in
            guard let self = self else { return }
            self.numRows = viewModel?.categories?.categories.items.count ?? 0
            self.loadingIndicator.stopAnimating()
            searchCollectionView.reloadData()
        }
    }
}


extension SearchCategoriesPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell()}
        guard let titleName = viewModel?.categories?.categories.items[indexPath.row].name,
              let url = viewModel?.categories?.categories.items[indexPath.row].icons.first?.url,
              let color = colors.randomElement()
        else { return cell}
        
        cell.configure(title: titleName, url: url, color: color)
        return cell
    }
}

extension SearchCategoriesPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 4
        return CGSize(width: width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = viewModel?.categories?.categories.items[indexPath.row].id else { return }
        guard let name = viewModel?.categories?.categories.items[indexPath.row].name else { return }
        viewModel?.showDetails(id: id, name: name)
    }
}

extension SearchCategoriesPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .SearchCategoriesPage
    }
}

