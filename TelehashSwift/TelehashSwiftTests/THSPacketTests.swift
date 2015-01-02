//
//  TelehashSwiftTests.swift
//  TelehashSwiftTests
//
//  Created by David Waite on 12/25/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

import Cocoa
import XCTest
import TelehashSwift
import SwiftyJSON

class THSPacketTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
      
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONConstructor() {
        let packet = THSPacket(jsonHeader:JSON([:]), body: NSData())
        XCTAssert(packet.jsonHeader != nil)
        XCTAssertEqual(packet.body.length, 0)
    }
    
  
}
