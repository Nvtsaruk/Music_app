//
//  FullPlayerViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 31.08.23.
//

import UIKit

class FullPlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

extension FullPlayerViewController: Storyboarded {
    static func containingStoryboard() -> Storyboard {
        .FullPlayer
    }
}
