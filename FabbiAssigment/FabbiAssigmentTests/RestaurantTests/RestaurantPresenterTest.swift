//
//  RestaurantPresenterTest.swift
//  FabbiAssigmentTests
//
//  Created by Maoo on 05/02/2024.
//

import XCTest
@testable import FabbiAssigment

class RestaurantPresenterTests: XCTestCase {

    var presenter: RestaurantPresenter!
    var view: MockPresenterToViewRestaurantProtocol!

    override func setUp() {
        super.setUp()
        view = MockPresenterToViewRestaurantProtocol()
        presenter = RestaurantPresenter()
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
        view = nil
    }

    func testShowRestaurant() {
        presenter.showRestaurant(with: ["Restaurant 1", "Restaurant 2"])
        XCTAssertEqual(view.getRestaurantDataCalled, true)
        XCTAssertEqual(view.restaurant, ["Restaurant 1", "Restaurant 2"])
    }

    func testShowRestaurantError() {
        presenter.showRestaurantError()
        XCTAssertEqual(view.showRestaurantErrorAlertCalled, true)
    }

}

class MockPresenterToViewRestaurantProtocol: PresenterToViewRestaurantProtocol {

    var getRestaurantDataCalled = false
    var restaurant: [String?] = []

    func getRestaurantData(restaurant: [String?]) {
        getRestaurantDataCalled = true
        self.restaurant = restaurant
    }

    var showRestaurantErrorAlertCalled = false

    func showRestaurantErrorAlert() {
        showRestaurantErrorAlertCalled = true
    }

}
