//
//  SearchPageCoordinator.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import Foundation
import UIKit

final class SearchPageCoordinator: Coordinator {
    func goToUserProfile() {
        
    }
    
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SearchCategoriesViewModel()
        viewModel.coordinator = self
        let searchCategoriesViewController = SearchCategoriesPageViewController.instantiate()
        searchCategoriesViewController.viewModel = viewModel
        navigationController.pushViewController(searchCategoriesViewController, animated: false)
    }
    func showSearchTabbar() {
        let viewModel = SearchPageViewModel()
        viewModel.coordinator = self
        let searchPageViewController = SearchPageViewController.instantiate()
        searchPageViewController.viewModel = viewModel
        navigationController.pushViewController(searchPageViewController, animated: false)
    }
    func popToRoot() {
        navigationController.popToRootViewController(animated: false)
    }
    
    func showDetails(id: String, name: String) {
        let viewModel = CategoriesDetailsViewModel()
        viewModel.coordinator = self
        viewModel.id = id
        viewModel.name = name
        let categoriesDetailsViewController = CategoriesDetailsViewController.instantiate()
        categoriesDetailsViewController.viewModel = viewModel
        navigationController.pushViewController(categoriesDetailsViewController, animated: true)
    }
    func showItemDetail(id: String) {
        let viewModel = ItemDetailViewModel()
//        viewModel.coordinator = self
        viewModel.id = id
        let itemDetailViewController = ItemDetailViewController.instantiate()
        itemDetailViewController.viewModel = viewModel
        navigationController.pushViewController(itemDetailViewController, animated: true)
    }
}
