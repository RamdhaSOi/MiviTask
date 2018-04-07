//
//  MiviTestTests.swift
//  MiviTestTests
//
//  Created by Moriarty on 06/04/18.
//  Copyright © 2018 Ramdhas. All rights reserved.
//

import XCTest
@testable import MiviTest

class MiviTestTests: XCTestCase {
    var loginVC = ViewController()
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard (name:"Main",bundle: nil)
        let vc: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        loginVC = vc
        _ = loginVC.view
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    /* Test valid login credentials */
    func testValidLoginCredentials() {
        loginVC.emailID.text = "test@mivi.com"
        loginVC.contactNumber.text = "0404000000"
        loginVC.submitBtn.sendActions(for: .touchUpInside)
        guard loginVC.isLoginSuccessfulCalled else {
            XCTFail("Login failed due to mistach credentials")
            return
        }
        
        XCTAssertTrue(loginVC.isLoginSuccessfulCalled,"Login Success")
    }
    
    /* Test login input has empty value */
    func testLoginInputEmpty() {
        loginVC.emailID.text = ""
        loginVC.contactNumber.text = ""
        loginVC.submitBtn.sendActions(for: .touchUpInside)
        XCTAssertTrue(loginVC.isLoginInputHasEmpty, "Login field has empty value")
    }
    
    /* Test whether collection json parsing */
    func testCollectionJsonParse() {
        let jsonDelegate = JsonHandler()
        jsonDelegate.fetchDataFromJsonFile()
        guard jsonDelegate.parseError == nil  else {
            XCTFail("Expected error of type LoginFormValidationError but got \(String(describing: jsonDelegate.parseError?.localizedDescription))")
            return
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
