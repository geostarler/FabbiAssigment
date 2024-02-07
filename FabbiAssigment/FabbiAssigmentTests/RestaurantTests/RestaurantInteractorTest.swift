//
//  RestaurantInteractorTest.swift
//  FabbiAssigmentTests
//
//  Created by Maoo on 05/02/2024.
//

import XCTest
@testable import FabbiAssigment

class RestaurantInteractorTests: XCTestCase {

    var interactor: RestaurantInteractor!
    var presenter: MockInteractorToPresenterRestaurantProtocol!
    var worker: MockInteractorToWorkerRestaurantProtocol!

    override func setUp() {
        super.setUp()
        presenter = MockInteractorToPresenterRestaurantProtocol()
        worker = MockInteractorToWorkerRestaurantProtocol()
        interactor = RestaurantInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
    }

    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
        worker = nil
    }

    func testUpdateOrder() {
        interactor.orderModel = OrderModel()
        interactor.updateOrder(restaurant: "Restaurant 1")
        XCTAssertEqual(interactor.orderModel?.restaurant, "Restaurant 1")
    }

    func testUpdateRestaurant() {
        interactor.orderModel = OrderModel(meal: "Breakfast", numerOfPeople: 2)
        interactor.updateRestaurant()
        XCTAssertEqual(presenter.showRestaurantCalled, true)
        XCTAssertEqual(presenter.restaurants, [])
    }

    func testHandlerError() {
        interactor.handlerError(restaurant: "")
        XCTAssertEqual(presenter.showRestaurantErrorCalled, true)
    }

    func testCheckRestaurantTextField() {
        XCTAssertFalse(interactor.checkRestaurantTextField(text: ""))
        XCTAssertTrue(interactor.checkRestaurantTextField(text: "Restaurant 1"))
    }

}

class MockInteractorToPresenterRestaurantProtocol: InteractorToPresenterRestaurantProtocol {
    var showRestaurantCalled = false
    var showRestaurantErrorCalled = false
    var restaurants: [String?] = []

    func showRestaurant(with restaurants: [String?]) {
        showRestaurantCalled = true
        self.restaurants = restaurants
    }

    func showRestaurantError() {
        showRestaurantErrorCalled = true
    }
}

class MockInteractorToWorkerRestaurantProtocol: InteractorToWorkerRestaurantProtocol {

    var dishes: Dishes?

}

struct Dishes {
    var dishes: [Dish]
}

struct Dish {
    var restaurant: String
    var availableMeals: [String]
    var dishes: [DishModel]
}

struct DishModel {
    var name: String
    var price: Double
}

extension RestaurantInteractorTests {

    func decodeUser(from data: String) -> Dishes? {
        // Implement your decoding logic here
        return nil
    }

}
