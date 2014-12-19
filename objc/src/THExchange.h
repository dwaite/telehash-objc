//
//  THExchange.h
//  telehash
//
//  Created by David Waite on 10/14/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THLob.h"

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

@interface THExchange : NSObject

-(instancetype) initWithNetwork: (THNetwork *) network
                      cipherset: (THCipherSet) csid
                          inner: (THLob *)     inner
                             at: (NSDate *)    at;
-(void) dealloc;

-(THMessage*) createMessage: (THLob*) inner sequence: (uint32_t) seq;
-(uint8_t) verify:(THLob*) message;
-(uint32_t) sync: (THLob*) handshake;
-(THMessage*) handshake: (THLob*) inner sequence: (uint32_t) seq;

-(THLob*) receive: (NSData*) packet;
-(NSData*) send: (THLob*) message;

-(uint32_t) nextChannelId;

@property (readonly) NSString* token; // or NSData?
@property (readonly) uint32_t at;     // or NSDate
@end
