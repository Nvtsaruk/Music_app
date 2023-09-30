import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    //MARK: -IBOutlet
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var albumImage: UIImageView!
    
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
}
