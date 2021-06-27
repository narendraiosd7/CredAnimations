//
//  MainViewController.swift
//  CredTask
//
//  Created by narendra.vadde on 27/06/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var mainView: MainView!
    
    var viewModel = PlansViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.delegate = self
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.circleSlider.frame = mainView.sliderView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.setupContainer()
    }
}

extension MainViewController: MainViewDataDelegate {
    func getEMIPlansDataFor(selectedAmount: Int) {
        viewModel.getData(selectedAmount: selectedAmount)
    }
}

extension MainViewController: PlansViewModelDelegate {
    func updateUI() {
        mainView.plans = viewModel.plans
    }
}
