//
//  THChannel.m
//  telehash
//
//  Created by David Waite on 10/15/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#import "THChannel.h"
#import "THError.h"
#import "THInternal.inc"

@implementation THChannel
-(instancetype) initWithOpen:(NSData*)open {
  if ((self = [super init])) {
    lob_t lob = lob_parse(open.bytes, open.length);
    _channel = e3x_channel_new(lob);
    return self;
  }
  return nil;
}

-(void) dealloc {
  e3x_channel_free(_channel);
}

-(BOOL)receive: (NSData*) inner error: (NSError**) error{
  lob_t lob = lob_parse(inner.bytes, inner.length);
  uint8_t result = e3x_channel_receive(_channel, lob);
  lob_free(lob);
  switch (result) {
    case 0:
      return YES;
    default:
      if (error != nil)
        *error = [THError errorFromReceiveErrorCode:result];
      return NO;
  };
}

//-(void) sync: (uint8_t) sync {
//  
//}
//
//-(NSData*) receiving;
//-(NSData*) oob;
//-(NSData*) packet;
//
//-(uint8_t) send: (NSData*) inner;
//-(NSData*) sending;
//
//
//@property (readwrite) NSUInteger size;
//@property (readwrite) NSTimeInterval timeout;
//@property (readonly) NSString *uid;
//@property (readonly) NSUInteger channel_id;
//@property (readonly) NSString *channel_id_str;
//@property (readonly) NSData* open;
//@property (readonly) THChannelState state;
@end
