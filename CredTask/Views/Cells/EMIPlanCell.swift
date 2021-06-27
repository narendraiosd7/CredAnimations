//
//  EMIPlanCell.swift
//  CredTask
//
//  Created by narendra.vadde on 27/06/21.
//

import UIKit

class EMIPlanCell: UICollectionViewCell {

    @IBOutlet weak var dataContainer: UIView!
    @IBOutlet weak var checkboxImage: UIImageView!
    @IBOutlet weak var EMIAmountLabel: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var recommendedLabel: UILabel!
    
    var emiAmountStr = ""
    var timeStr = ""
    var color: UIColor?
    var isRecommended = false
    var isCellSelected: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recommendedLabel.roundCorners(cornerRadius: 15)
        dataContainer.roundCorners(cornerRadius: 20)
        checkboxImage.image = UIImage(named: Config.shared.images.unchecked)
    }

    func updateUI() {
        dataContainer.backgroundColor = color
        EMIAmountLabel.text = emiAmountStr
        timePeriodLabel.text = timeStr
        recommendedLabel.isHidden = !isRecommended
        checkboxImage.image = UIImage(named: (isCellSelected ?? false) ? Config.shared.images.check : Config.shared.images.unchecked)
    }
}
