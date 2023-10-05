import UIKit
final class SearchCollectionViewCell: UICollectionViewCell {
    //MARK: -IBOutlet
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var albumImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        albumImage.layer.cornerRadius = 8
        albumImage.transform = CGAffineTransform(rotationAngle: 0.2)
    }
    func configure(title: String, url: String, color: UIColor) {
        containerView.backgroundColor = color
        titleLabel.text = title
        albumImage.webImage(url: url)
    }
}
