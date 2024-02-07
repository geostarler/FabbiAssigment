//
//  CategoryInteractorTest.swift
//  FabbiAssigmentTests
//
//  Created by Maoo on 05/02/2024.
//

import XCTest
@testable import FabbiAssigment

class CategoryInteractorTests: XCTestCase {

    var interactor: CategoryInteractor!
    var presenter: MockInteractorToPresenterCategoryProtocol!
    var worker: MockInteractorToWorkerCategoryProtocol!

    override func setUp() {
        super.setUp()
        presenter = MockInteractorToPresenterCategoryProtocol()
        worker = MockInteractorToWorkerCategoryProtocol()
        interactor = CategoryInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        worker = nil
        interactor = nil
    }

    func testUpdateMeal() {
        interactor.updateMeal()
        XCTAssertEqual(presenter.showMealCalled, true)
    }

    func testUpdateOrder() {
        interactor.updateOrder(meal: "Breakfast", numberOfPeople: 2)
        XCTAssertEqual(interactor.orderModel?.meal, "Breakfast")
        XCTAssertEqual(interactor.orderModel?.numerOfPeople, 2)
    }

    func testCheckMealTextField() {
        XCTAssertTrue(interactor.checkMealTextField(text: "Breakfast"))
        XCTAssertFalse(interactor.checkMealTextField(text: ""))
    }

    func testCheckNumberOfPeopleTextField() {
        XCTAssertTrue(interactor.checkNumberOfPeopleTextField(text: "10"))
        XCTAssertFalse(interactor.checkNumberOfPeopleTextField(text: "11"))
    }

    func testHandlerError() {
        interactor.handlerError(meal: "", numberOfPeople: "11")
        XCTAssertEqual(presenter.showMealErrorCalled, true)
        interactor.handlerError(meal: "Breakfast", numberOfPeople: "11")
        XCTAssertEqual(presenter.showNumberOfPeopleErrorCalled, true)
    }

}

class MockInteractorToPresenterCategoryProtocol: InteractorToPresenterCategoryProtocol {

    var showMealCalled = false
    func showMeal(with mealModels: [String?]) {
        showMealCalled = true
    }

    var showMealErrorCalled = false
    func showMealError() {
        showMealErrorCalled = true
    }

    var showNumberOfPeopleErrorCalled = false
    func showNumberOfPeopleError() {
        showNumberOfPeopleErrorCalled = true
    }

}

class MockInteractorToWorkerCategoryProtocol: InteractorToWorkerCategoryProtocol {

}
