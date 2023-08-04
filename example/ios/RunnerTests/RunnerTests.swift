import Flutter
import UIKit
import XCTest

@testable import recco

class RunnerTests: XCTestCase {
    
    func testLogout() {
        let plugin = ReccoPlugin()
        let call = FlutterMethodCall(methodName: "logout", arguments: [])
        let resultExpectation = expectation(description: "result block must be called.")
        
        plugin.handle(call) { result in
            if let logoutResult = result as? FlutterError {
                XCTAssertEqual(logoutResult.code, "logoutError")
            } else if let logoutResult = result as? String {
                XCTAssertNil(logoutResult)
            }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testLogin() {
        let plugin = ReccoPlugin()
        var params: [String: Any] = ["userId":"userId"]
        let call = FlutterMethodCall(methodName: "login", arguments: params)
        let resultExpectation = expectation(description: "result block must be called.")
        
        plugin.handle(call) { result in
            if let loginResult = result as? FlutterError {
                XCTAssertEqual(loginResult.code, "loginError")
            } else if let loginResult = result as? String {
                XCTAssertNil(loginResult)
            }
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testOpenReccoUi() {
        let plugin = ReccoPlugin()
        let call = FlutterMethodCall(methodName: "openReccoUi", arguments: [])
        let resultExpectation = expectation(description: "result block must be called.")
        
        plugin.handle(call) { result in
            if let openReccoUiResult = result as? String {
                XCTAssertNil(openReccoUiResult)
            }
            
            resultExpectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
}
