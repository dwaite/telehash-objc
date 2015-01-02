//
//  THChannel.h
//  telehash
//
//  Created by David Waite on 10/15/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

@import Foundation;
#import "THPacket.h"

@class THEvent;

typedef NS_ENUM(NSUInteger, THChannelState) {
  THChannelStateOpening,
  THChannelStateOpened,
  THChannelStateClosed,
};

@interface THChannel : NSObject

-(instancetype) initWithOpen:(NSData*)open;
-(void) dealloc;

-(BOOL)receive: (NSData*) inner error: (NSError**) error;
-(void) sync: (uint8_t) sync;

-(NSData*) receiving;
-(NSData*) oob;
-(NSData*) packet;

-(uint8_t) send: (NSData*) inner;
-(NSData*) sending;


@property (readwrite) NSUInteger size;
@property (readwrite) NSTimeInterval timeout;
@property (readonly) NSString *uid;
@property (readonly) NSUInteger channel_id;
@property (readonly) NSString *channel_id_str;
@property (readonly) NSData* open;
@property (readonly) THChannelState state;

@end