//
//  ReviewViewController.swift
//  FabbiAssigment
//
//  Created by Maoo on 04/02/2024.
//  
//

import UIKit

protocol PresenterToViewReviewProtocol: AnyObject {
    func updateUI(order: OrderModel)
}

final class ReviewViewController: BaseViewController {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var stepBarView: StepBarView!
    @IBOutlet private weak var reviewTableView: UITableView!
    @IBOutlet private var listDetail: [DetailView]!
    @IBOutlet private weak var dishesTitleLabel: UILabel!
    @IBOutlet private weak var buttonView: ButtonView!
    
    // MARK: - Public Variable
    
    var interactor: ViewToInteractorReviewProtocol?
    var router: (ViewToRouterReviewProtocol & DataPassingReviewProtocol)?
    
    // MARK: - Private Variable
    private let setupViewModel: SetupViewModel = SetupViewModel(step: 4, isShowLeftButton: true)
    private var orderData: OrderModel?
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        ReviewConfigurator.injectDependencies(for: self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        ReviewConfigurator.injectDependencies(for: self)
    }
    
    override func setupView() {
        super.setupView()
        registerCell()
        handleButton()
        stepBarView.setupViewForStep(step: setupViewModel.step)
        buttonView.setUpButton(isShowLeftButton: setupViewModel.isShowLeftButton, isSubmitButton: true)
    }
    
    override func applyLocalization() {
        interactor?.getOrder()
        listDetail[0].updateText(title: R.string.localizable.meal(), detail: orderData?.meal ?? "")
        listDetail[1].updateText(title: R.string.localizable.no_people(), detail: String(orderData?.numerOfPeople ?? 0))
        listDetail[2].updateText(title: R.string.localizable.restaurant(), detail: orderData?.restaurant ?? "")
        dishesTitleLabel.text = R.string.localizable.dishes()
    }
}

// MARK: - IBAction

private extension ReviewViewController {
    func handleButton() {
        buttonView.onLeftButtonClicked = { [weak self] in
            self?.router?.backToDishes()
        }
        buttonView.onRightButtonClicked = { [weak self] in
            self?.router?.goToFinish()
        }
    }
}

// MARK: - PresenterToView

extension ReviewViewController: PresenterToViewReviewProtocol {
    func updateUI(order: OrderModel) {
        orderData = order
        self.reviewTableView.reloadData()
    }
}

// MARK: - Private

private extension ReviewViewController {
    func registerCell() {
        reviewTableView.register(DetailCell.self)
    }
}

// MARK: - UITableview
extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData?.dishes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(DetailCell.self, for: indexPath)
        guard let order = orderData?.dishes?[indexPath.row] else { return UITableViewCell()}
        cell.setUpCell(name: order.dish ?? "", info: String(order.noOfServing ?? 0))
        return cell
    }
}

