//
//  KarumiHQsSpec.swift
//  MaxibonKataIOS
//
//  Created by Pia on 25/3/17.
//  Copyright © 2017 GoKarumi. All rights reserved.
//

import XCTest
import Foundation
import SwiftCheck
@testable import MaxibonKataIOS

class KarumiHQsSpec: XCTestCase {
    
    func testAll() {
        property("Number of maxibons is always > 2", arguments: CheckerArguments(maxAllowableSuccessfulTests: 40))
            <- forAll(Developer.arbitraryHungry, pf: { (developer: Developer) -> Testable in
                let karumiHQ = KarumiHQs()
                karumiHQ.openFridge(developer)
                return karumiHQ.maxibonsLeft > 2
        })
        
        property("Number of maxibons is always > 2 with array", arguments: CheckerArguments(maxAllowableSuccessfulTests: 40))
            <- forAll({ (developers: ArrayOf<Developer>) -> Testable in
                let karumiHQ = KarumiHQs()
                karumiHQ.openFridge(developers.getArray)
                return karumiHQ.maxibonsLeft > 2
        })
    }
    
    func testChat() {
        //Siempre se envia chat
        property("If there are two or less maxibons after opening the fridge the developer sends a message to buy more")
            <- forAll(Developer.arbitraryHungry) { (developer: Developer) in
                let chat = MockChat()
                let karumiHQs = KarumiHQs(chat: chat)
                karumiHQs.openFridge(developer)
                let expectedResult = chat.messageSent == "Hi guys, I'm \(developer.name). We need more maxibons!"
                chat.messageSent = nil
                return expectedResult
        }
        
        //Nunca se envia chat
        property("If there are more than two maxibons after opening the fridge the developer does NOT send a message to buy more")
            <- forAll(Developer.arbitraryNotSoHungry) { (developer: Developer) in
                let chat = MockChat()
                let karumiHQs = KarumiHQs(chat: chat)
                karumiHQs.openFridge(developer)
                let expectedResult = chat.messageSent == nil
                chat.messageSent = nil
                return expectedResult
        }
        
        //TODO: hacerlo con ArrayOf + generator 0-20 para probar cuando algunos envíen chat y otros no
    }
}

extension ArrayOf {
    //Return generator of 'ArrayOf' developers with custom generator (not arbitrary)
    
}
