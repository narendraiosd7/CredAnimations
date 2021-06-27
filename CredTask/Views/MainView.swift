//
//  MainView.swift
//  CredTask
//
//  Created by narendra.vadde on 27/06/21.
//

import UIKit
import CircleSlider

protocol MainViewDataSource: AnyObject {
    
}

protocol MainViewDataDelegate: AnyObject {
    func getEMIPlansDataFor(selectedAmount: Int)
}

class MainView: UIView {

    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var amountSelectionView: UIView!
    @IBOutlet weak var dailContainer: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var creditAmountLabel: UILabel!
    @IBOutlet weak var amountSelctionViewHeader: UIView!
    @IBOutlet weak var selectedAmountLabel: UILabel!
    @IBOutlet weak var proceedToEMIButton: UIButton!
    @IBOutlet weak var amountSelectioViewExpandButton: UIButton!
    
    @IBOutlet weak var emiSelectionView: UIView!
    @IBOutlet weak var emiSelectionViewHeader: UIView!
    @IBOutlet weak var emiAMountLabel: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var emiSelectionCollectionView: UICollectionView!
    @IBOutlet weak var createYourOwnPlanButton: UIButton!
    @IBOutlet weak var selectYourBankAccountButton: UIButton!
    @IBOutlet weak var emiSelectionViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bankSelectionView: UIView!
    @IBOutlet weak var bankSelectionCheckboxImage: UIImageView!
    @IBOutlet weak var bankLogo: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankAccountLabel: UILabel!
    @IBOutlet weak var changeAccountButton: UIButton!
    @IBOutlet weak var tapFor1ClickKYCButton: UIButton!
    @IBOutlet weak var bankSelectionViewBottomConstraint: NSLayoutConstraint!
    
    var isAmountSelctionViewHeaderToggled = false
    var isEMISelectionViewHeaderToggled = false
    var isBankAccountSelected = false
    var selectedAmount = 3000
    var numberFormatter: NumberFormatter?
    weak var delegate: MainViewDataDelegate?
    weak var dataSource: MainViewDataSource?
    var plans = [Plan]()
//    var selectedIndex = 0
    var circleSlider: CircleSlider!
    var minValue: Float = 3000
    var maxValue: Float = 487891
    var sliderOptions: [CircleSliderOption] {
        return [
            CircleSliderOption.barColor(Config.shared.colors.barColor),
            CircleSliderOption.thumbColor(Config.shared.colors.backgroundColor),
            CircleSliderOption.trackingColor(Config.shared.colors.trackingColor),
            CircleSliderOption.barWidth(10),
            CircleSliderOption.startAngle(270),
            CircleSliderOption.maxValue(self.maxValue),
            CircleSliderOption.minValue(self.minValue),
            CircleSliderOption.thumbImage(UIImage(named: Config.shared.images.uncheck))
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountSelectionView.topCorners(20)
        dailContainer.roundCorners(cornerRadius: 20)
        proceedToEMIButton.topCorners(20)
        amountSelctionViewHeader.roundCorners(cornerRadius: 20)
        amountSelctionViewHeader.isHidden = true
        
        numberFormatter = NumberFormatter()
        numberFormatter?.locale = Locale(identifier: "en_IN")
        numberFormatter?.numberStyle = .decimal
        
        creditAmountLabel.text = "₹ " + (numberFormatter?.string(from: NSNumber(value: selectedAmount)) ?? "")
        emiSelectionView.topCorners(20)
        createYourOwnPlanButton.customBorderButton(.white, 1, 20)
        selectYourBankAccountButton.topCorners(20)
        emiSelectionViewHeader.topCorners(20)
        emiSelectionViewHeader.isHidden = true
        
        bankSelectionView.topCorners(20)
        bankLogo.roundCorners(cornerRadius: 15)
        tapFor1ClickKYCButton.topCorners(20)
        changeAccountButton.customBorderButton(.white, 1, 20)
        bankSelectionCheckboxImage.image = UIImage(named: Config.shared.images.unchecked)
        
        emiSelectionCollectionView.register(UINib.init(nibName: "EMIPlanCell", bundle: Bundle.main), forCellWithReuseIdentifier: "EMIPlanCell")
        emiSelectionCollectionView.dataSource = self
        emiSelectionCollectionView.delegate = self
        
        setupViews()
        buildCircleSlider()
    }
    
    func setupViews() {
        emiSelectionView.alpha = 0
        bankSelectionView.alpha = 0
        isAmountSelctionViewHeaderToggled = !isAmountSelctionViewHeaderToggled
        isEMISelectionViewHeaderToggled = !isEMISelectionViewHeaderToggled
    }
    
    func buildCircleSlider() {
        circleSlider = CircleSlider(frame: sliderView.bounds, options: sliderOptions)
        circleSlider?.addTarget(self, action: #selector(valueChange(sender:)), for: .valueChanged)
        sliderView.addSubview(circleSlider!)
        circleSlider.delegate = self
    }
    
    @objc func valueChange(sender: CircleSlider) {
        selectedAmount = Int(sender.value)
        creditAmountLabel.text = "₹ " + (numberFormatter?.string(from: NSNumber(value: selectedAmount)) ?? "")
    }
    
    func setupContainer() {
        let bottomConstant = emiSelectionView.frame.size.height + 50
        emiSelectionViewBottomConstraint.constant = bottomConstant
        bankSelectionViewBottomConstraint.constant = -bottomConstant
        ViewAnimationFactory.makeEaseOutAnimation(duration: 0.3, delay: 0, action: {
            self.emiSelectionView.alpha = 1
            self.bankSelectionView.alpha = 1
        })
    }
    
    func amountSelectionViewHandling() {
        if isAmountSelctionViewHeaderToggled {
           emiSelectionViewBottomConstraint.constant = 0
        } else {
            let bottomConstant = emiSelectionView.frame.size.height + 50
            emiSelectionViewBottomConstraint.constant = bottomConstant
        }
        
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.3, delay: 0) {
            self.layoutIfNeeded()
            self.isAmountSelctionViewHeaderToggled = !self.isAmountSelctionViewHeaderToggled
        }
    }
    
    func emiSelectionViewHandling() {
        if isEMISelectionViewHeaderToggled {
            self.bankSelectionViewBottomConstraint.constant = 0
        } else {
            let bottomConstant = bankSelectionView.frame.size.height + 50
            self.bankSelectionViewBottomConstraint.constant = -bottomConstant
        }
        
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.3, delay: 0) {
            self.layoutIfNeeded()
            self.isEMISelectionViewHeaderToggled = !self.isEMISelectionViewHeaderToggled
        }
    }
    
    @IBAction func proceedToEMITapped(_ sender: UIButton) {
        selectedAmountLabel.text = "₹ " + (numberFormatter?.string(from: NSNumber(value: selectedAmount)) ?? "")
        amountSelctionViewHeader.isHidden = false
        delegate?.getEMIPlansDataFor(selectedAmount: selectedAmount)
        emiSelectionCollectionView.reloadData()
        amountSelectionViewHandling()
    }
    
    @IBAction func amountSelectionViewExpandTapped(_ sender: UIButton) {
        amountSelctionViewHeader.isHidden = true
        amountSelectionViewHandling()
    }
    
    @IBAction func selectYourBankAccountTapped(_ sender: UIButton) {
        emiSelectionViewHeader.isHidden = false
        amountSelectioViewExpandButton.isEnabled = false
        emiSelectionViewHandling()
    }
    
    @IBAction func EMISelectionViewExpandTapped(_ sender: UIButton) {
        emiSelectionViewHeader.isHidden = true
        amountSelectioViewExpandButton.isEnabled = true
        emiSelectionViewHandling()
    }
    
    @IBAction func bankSelctionCheckboxTapped(_ sender: UIButton) {
        isBankAccountSelected = !isBankAccountSelected
        bankSelectionCheckboxImage.image = UIImage(named: isBankAccountSelected ? Config.shared.images.check : Config.shared.images.unchecked)
    }
}

extension MainView: CircleSliderDelegate {
    func didStartChangeValue() {
        print("didStartChangeValue")
    }
    
    func didReachedMaxValue() {
        print("didReachedMaxValue")
    }
}

extension MainView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plans.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EMIPlanCell", for: indexPath) as! EMIPlanCell
        cell.emiAmountStr =  "₹ " + (numberFormatter?.string(from: NSNumber(value: plans[indexPath.row].amount ?? 0)) ?? "") + " /mo"
        cell.timeStr = plans[indexPath.row].timePeriod ?? ""
        cell.isRecommended = plans[indexPath.row].isRecommended ?? false
        cell.color = plans[indexPath.row].color ?? .black
        cell.isCellSelected = plans[indexPath.row].isCellChecked ?? false
        cell.updateUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2), height: (UIScreen.main.bounds.width/1.6))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? EMIPlanCell
        cell?.isCellSelected = true
        emiAMountLabel.text = "₹ " + (numberFormatter?.string(from: NSNumber(value: plans[indexPath.row].amount ?? 0)) ?? "") + " /mo"
        timePeriodLabel.text = plans[indexPath.row].timePeriod ?? ""
        cell?.updateUI()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? EMIPlanCell
        cell?.isCellSelected = false
        cell?.updateUI()
    }
}
