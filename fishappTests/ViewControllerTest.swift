//
//  fishappTests.swift
//  fishappTests
//
//  Created by Jannik Feuerhahn on 20.10.20.
//

import Foundation
import XCTest
@testable import fishapp

class ViewControlerTest: XCTestCase {

    func test_ViewControllerBackgroundIsYellow() {
        let sut = ViewController()
        _ = sut.view
        XCTAssertEqual(sut.view.backgroundColor, UIColor.yellow);
    }
}
