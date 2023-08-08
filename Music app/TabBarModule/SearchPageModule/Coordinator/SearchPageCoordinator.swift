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
        let viewModel = SearchPageViewModel()
        let searchPageViewController = SearchPageViewController.instantiate()
        searchPageViewController.viewModel = viewModel
        navigationController.pushViewController(searchPageViewController, animated: true)
    }
}
