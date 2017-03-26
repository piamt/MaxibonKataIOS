//
//  DeveloperSpec.swift
//  
//
//  Created by Pia on 25/3/17.
//
//

import XCTest
import Foundation
import SwiftCheck
@testable import MaxibonKataIOS

class DeveloperSpec: XCTestCase {
    
    func testTheNumberOfMaxibonsPerKarumieAre() {
        XCTAssertEqual(3, Karumies.Pedro.numberOfMaxibonsToGet)
        XCTAssertEqual(0, Karumies.Davide.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Alberto.numberOfMaxibonsToGet)
        XCTAssertEqual(2, Karumies.Jorge.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Sergio.numberOfMaxibonsToGet)
        XCTAssertEqual(1, Karumies.Fran.numberOfMaxibonsToGet)
    }

    func testAll() {
        property("Number of maxibons to consume can not be negative")
            <- forAll(Developer.arbitrary, pf: { (developer: Developer) -> Testable in
                print(developer)
                return developer.numberOfMaxibonsToGet >= 0
        })
    }
}
