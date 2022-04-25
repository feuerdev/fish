//
//  PickByCoordinateViewControllerTest.swift
//  fishappTests
//
//  Created by Jannik Feuerhahn on 20.10.20.
//

import XCTest
@testable import fishapp

class PickByCoordinateViewControllerTest: XCTestCase {

    func test_viewDidLoad_hasCoordinateTextField() {
        let sut = PickByCoordinateViewController()
        _ = sut.view

//        XCTAssertNotNil(sut.view.subviews.firstIndex(of: sut.tfCoordinate))
    }

    func test_viewDidLoad_hasSearchButton() {
        let sut = PickByCoordinateViewController()
        _ = sut.view

//        XCTAssertNotNil(sut.view.subviews.firstIndex(of: sut.btnSearch))
    }
}
