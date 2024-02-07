//
//  StepBarView.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//

import UIKit

@IBDesignable
class StepBarView: BaseView {

    @IBOutlet private weak var progressBarView: UIProgressView!
    @IBOutlet private var listStepBarView: [UIView]!
    @IBOutlet private var listStepNameLabel: [UILabel]!
    @IBOutlet private var listStepView: [UIView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStepName()
    }
    
    func setupViewForStep(step: Int) {
        let totalStep = 4
        if step < totalStep {
            for i in 0...listStepBarView[step - 1].tag {
                listStepBarView[i].backgroundColor = R.color.darkGreen()
                listStepNameLabel[i].textColor = R.color.darkGreen()
            }
            for j in (step - 1)...listStepBarView.count - 1 {
                listStepBarView[j].backgroundColor = .cyan
                listStepNameLabel[j].textColor = .black
            }
        } else {
            for item in 0...(listStepBarView.count - 1) {
                listStepBarView[item].backgroundColor = R.color.darkGreen()
                listStepNameLabel[item].textColor = R.color.darkGreen()
            }
        }
        updateProgessView(step: step)
    }
    
    func setStepName() {
        let stepNameArr = [R.string.localizable.step_1(),
                           R.string.localizable.step_2(),
                           R.string.localizable.step_3(),
                           R.string.localizable.step_4()]
        for i in 0...listStepNameLabel.count - 1 {
            listStepNameLabel[i].text = stepNameArr[i]
        }
    }
    
    func updateProgessView(step: Int) {
        let proggess: Float = 0.32 * Float(step - 1)
        progressBarView.setProgress(proggess , animated: true)
    }
}
