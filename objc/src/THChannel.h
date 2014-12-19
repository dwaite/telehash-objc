//
//  THChannel.h
//  telehash
//
//  Created by David Waite on 10/15/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THLob.h"

@class THEvent;

typedef NS_ENUM(NSUInteger, THChannelState) {
  THChannelStateOpening,
  THChannelStateOpened,
  THChannelStateClosed,
};
@interface THChannel : NSObject

-(instancetype) initWithOpen:(THLob*)open;
-(void) dealloc;

-(void) ev: (THEvent*) event;

-(uint8_t)receive: (THLob*) inner;
-(void) sync: (BOOL) sync;
-(THLob*) receiving;
-(THLob*) packet;
-(uint8_t) send: (THLob*) inner;
-(THLob*) sending;

@property (readonly) uint32_t channel_id;
@property (readonly) THLob* open;
@property (readonly) THChannelState state;
@property (readonly) NSUInteger size;

@end
