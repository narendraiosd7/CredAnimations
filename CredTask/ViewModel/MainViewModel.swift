//
//  MainViewModel.swift
//  CredTask
//
//  Created by narendra.vadde on 27/06/21.
//

import Foundation

protocol PlansViewModelDelegate: AnyObject {
    func updateUI()
}

class PlansViewModel {
    
    weak var delegate: PlansViewModelDelegate?
    
    var plans = [Plan]()
    
    func getData(selectedAmount: Int) {
        plans.removeAll()
        plans.append(Plan(isRecommended: false, amount: Int(selectedAmount/12), timePeriod: "for 12 months", color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), isCellChecked: false))
        plans.append(Plan(isRecommended: true, amount: Int(selectedAmount/9), timePeriod: "for 9 months", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), isCellChecked: false))
        plans.append(Plan(isRecommended: false, amount: Int(selectedAmount/6), timePeriod: "for 6 months", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), isCellChecked: false))
        delegate?.updateUI()
    }
}
