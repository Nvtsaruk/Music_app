import UIKit
final class PlaylistsCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(description: String, imageUrl: String) {
        descriptionLabel.text = description
        imageView.webImage(url: imageUrl)
    }
}
