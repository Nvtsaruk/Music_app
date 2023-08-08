//
//  SearchPageViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 8.08.23.
//

import UIKit

class SearchPageViewController: UIViewController {
    
    var viewModel: SearchPageViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchPageViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .SearchPage
    }
    
    
}
