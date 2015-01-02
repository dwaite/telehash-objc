//
//  THExchange.h
//  telehash
//
//  Created by David Waite on 10/14/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

@import Foundation;

@class THNetwork;
@class THMessage;

typedef NS_ENUM(NSUInteger, THCipherSet) {
  THCipherSet1A = 0x1a,
  THCipherSet1B = 0x1b,
  THCipherSet1C = 0x1c,
  THCipherSet2A = 0x2a,
  THCipherSet2B = 0x2b,
  THCipherSet3A = 0x3a
};

typedef uint32_t THAt;

@interface THExchange : NSObject

-(instancetype) initWithNetwork: (THNetwork *) network
                      cipherset: (THCipherSet) csid
                          inner: (NSData *)     inner;
-(NSData*) createMessage: (NSData*) inner;
-(BOOL) verifyMessage:(NSData*) outer error: (NSError**) error;

-(THExchange*) sync: (NSData*) handshake;
-(THMessage*) handshake;

-(NSData*) receive: (NSData*) packet;
-(NSData*) send: (NSData*) message;

-(NSUInteger) channelId: (NSData*) incoming;

@property (readonly) NSData* token;
@property (readwrite) THAt incomingAt;
@property (readwrite) THAt outgoingAt;
@end
