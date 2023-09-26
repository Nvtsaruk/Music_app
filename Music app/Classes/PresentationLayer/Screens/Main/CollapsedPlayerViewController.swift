//
//  TestViewController.swift
//  Music app
//
//  Created by Tsaruk Nick on 25.08.23.
//

import UIKit

class CollapsedPlayerViewController: UIViewController {

    var isPlaying: Bool = false
    let playButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerUI()
    }
    
    func setupPlayerUI() {
        view.backgroundColor = .gray
        // Do any additional setup after loading the view.
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .white
//        playButton.backgroundColor = .green
//        playButton.layer.cornerRadius = 20
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
//            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playButton.heightAnchor.constraint(equalToConstant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 40),
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let albumImage = UIImageView()
        guard let url = URL(string: "https://charts-images.scdn.co/assets/locale_en/viral/daily/region_global_large.jpg") else { return }
        albumImage.sd_setImage(with: url)
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        albumImage.layer.cornerRadius = 8
        view.addSubview(albumImage)
        NSLayoutConstraint.activate([
            albumImage.widthAnchor.constraint(equalToConstant: 60),
            albumImage.heightAnchor.constraint(equalToConstant: 60),
            albumImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func playButtonAction() {
        
        if isPlaying == true {
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            isPlaying = false
        } else {
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            isPlaying = true
        }
        print("Working button")
        
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
