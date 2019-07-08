//
//  WSJTests.swift
//  WSJTests
//
//  Created by Nick on 5/13/19.
//  Copyright © 2019 NickOwn. All rights reserved.
//

import XCTest
@testable import WSJ

class WSJTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSourceType() {
        
        let vm = MainViewModel(Source: .Lifestyle)
        XCTAssert(vm.sourceType == .Lifestyle)
        
    }



}
