//
//  THSPacket.swift
//  TelehashSwift
//
//  Created by David Waite on 12/25/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc public class THSPacket : NSObject {
  
  public let jsonHeader:   JSON?   = nil
  public let binaryHeader: NSData? = nil
  public let body:         NSData
  
  public init(jsonHeader: JSON, body: NSData) {
    self.jsonHeader = jsonHeader
    self.body = body
  }
  
  public init(binaryHeader: NSData, body: NSData) {
    self.binaryHeader = binaryHeader
    self.body = body
  }
  
  required public init(coder decoder: NSCoder) {
    self.body = decoder.decodeObjectOfClass(NSData.self, forKey: "body") as NSData
    let jh = decoder.decodeObjectOfClass(NSDictionary.self, forKey: "jsonHeader") as NSDictionary?
    if let dict = jh {
        self.jsonHeader = JSON(dict)
    }
    else {
        self.binaryHeader = decoder.decodeObjectOfClass(NSData.self, forKey: "binaryHeader") as NSData!
    }
    super.init()
  }
}

extension THSPacket  {
  convenience init?(data: NSData, error: NSErrorPointer = nil) {
    var lenData : [UInt8] = [UInt8](count:2, repeatedValue: 0)
    
    data.getBytes(&lenData, length: 2)
    let len:Int = Int(lenData[0]) << 8 + Int(lenData[1])
    let header = data.subdataWithRange(NSMakeRange(2, len))
    let body = data.subdataWithRange(NSMakeRange(2 + len, Int(INT_MAX)))
    if header.length <= 7 {
      self.init(binaryHeader: header, body: body)
      return
    }
    
    let json = JSON(data: header, options: nil, error: error)
    switch json.type {
    case .Dictionary:
      self.init(jsonHeader: json, body: body)
      return
    case .Array:
      if error != nil {
        error.memory = NSError(domain: "Telehash", code: 0, userInfo:
          [ NSLocalizedFailureReasonErrorKey : "Header data was array" ])
      }
      self.init(binaryHeader: NSData(), body:body)
      return nil
    case .Null:
        self.init(binaryHeader: NSData(), body:body)
      return nil
    default:
      if error != nil {
        error.memory = NSError(domain: "Telehash", code: 0, userInfo:
          [NSLocalizedFailureReasonErrorKey : "Unknown header value" ])
      }
      self.init(binaryHeader: NSData(), body:body)
      return nil
    }
  }
}

extension THSPacket : NSCoding, NSSecureCoding {
  public func encodeWithCoder(encoder: NSCoder) {
    if let obj = jsonHeader?.dictionaryObject {
      encoder.encodeObject(obj, forKey: "jsonHeader")
    }
    encoder.encodeObject(binaryHeader, forKey: "binaryHeader")
    encoder.encodeObject(body, forKey: "body")
  }
  public class func supportsSecureCoding() -> Bool {
    return true
  }
}

extension THSPacket : NSCopying {
  public func copyWithZone(zone: NSZone) -> AnyObject {
    if let jh = self.jsonHeader {
      return THSPacket(
        jsonHeader: JSON(jh.dictionaryObject!),
        body: self.body)
    }
    else {
      let bh = self.binaryHeader!
      return THSPacket(binaryHeader: bh, body: body)
    }
  }
}

extension THSPacket : NSObjectProtocol {
  public override func isEqual(_anObject: AnyObject?) -> Bool {
    if (super.isEqual(_anObject)) {
      return true;
    }
    if let rhs = _anObject as? THSPacket {
      let jsonMatches = self.jsonHeader == rhs.jsonHeader
      let binaryMatches = self.binaryHeader == rhs.binaryHeader
      let bodyMatches = self.body == rhs.body
      return jsonMatches && binaryMatches && bodyMatches
    }
    else
    {
      return false
    }
  }
  public override var hash: Int {
    get {
      return jsonHeader!.object.hash + (binaryHeader?.hashValue ?? 0) + body.hash
    }
  }
}

extension NSData {
  convenience init?(p : THSPacket) {
    var header:NSData
    let body = p.body ?? NSData()
    if let json = p.jsonHeader {
      header = json.rawData()!
    }
    else
    {
      header = p.binaryHeader!
    }
    let builder = NSMutableData(capacity: Int(2 + header.length + body.length))!
    var headerSize:[UInt8] = [ UInt8(header.length >> 8), UInt8(header.length & 0xff)]
    builder.appendBytes(&headerSize, length:2)
    builder.appendData(header)
    builder.appendData(body)
    self.init(data:builder)
  }
}
//extension THSPacket : NSMutableCopying {
//  func mutableCopyWithZone(zone: NSZone) -> AnyObject?
//}
//
//class THMutablePacket : THSPacket { // , NSCopying, NSMutableCopying, NSSecureCoding, NSCoding {
//  var binaryHeader: NSMutableData?;
//  var jsonHeader: [NSString:AnyObject?]?;
//  var body: NSMutableData?;
//  var hasJSONHeader: Bool;
//}
