//
//  CategoryPresenterTest.swift
//  FabbiAssigmentTests
//
//  Created by Maoo on 05/02/2024.
//

import XCTest
@testable import FabbiAssigment

class CategoryPresenterTests: XCTestCase {

    var presenter: CategoryPresenter!
    var view: MockPresenterToViewCategoryProtocol!

    override func setUp() {
        super.setUp()
        view = MockPresenterToViewCategoryProtocol()
        presenter = CategoryPresenter()
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    func testShowMeal() {
        let meal = ["Breakfast", "Lunch", "Dinner"]
        presenter.showMeal(with: meal)
        XCTAssertEqual(view.getMealDataCalled, true)
        XCTAssertEqual(view.meal, meal)
    }

    func testShowMealError() {
        presenter.showMealError()
        XCTAssertEqual(view.showMealErrorAlertCalled, true)
    }

    func testShowNumberOfPeopleError() {
        presenter.showNumberOfPeopleError()
        XCTAssertEqual(view.showNumberOfPeopleErrorAlertCalled, true)
    }

}

class MockPresenterToViewCategoryProtocol: PresenterToViewCategoryProtocol {

    var getMealDataCalled = false
    var meal: [String?] = []

    func getMealData(meal: [String?]) {
        getMealDataCalled = true
        self.meal = meal
    }

    var showMealErrorAlertCalled = false
    func showMealErrorAlert() {
        showMealErrorAlertCalled = true
    }

    var showNumberOfPeopleErrorAlertCalled = false
    func showNumberOfPeopleErrorAlert() {
        showNumberOfPeopleErrorAlertCalled = true
    }

}
