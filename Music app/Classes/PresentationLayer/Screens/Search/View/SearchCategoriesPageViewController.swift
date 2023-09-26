//
//  SearchPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import UIKit

class SearchCategoriesPageViewController: UIViewController {
    
    
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchContainerText: UILabel!
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
        cell.titleLabel.text = viewModel?.categories?.categories.items[indexPath.row].name
        let url = viewModel?.categories?.categories.items[indexPath.row].icons.first?.url
        cell.albumImage.webImage(url: url)
        cell.containerView.backgroundColor = colors.randomElement()
        return cell
    }
    
    
}
extension SearchCategoriesPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height)
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

