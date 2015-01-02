//
//  THInternal.h
//  Telehash
//
//  Created by David Waite on 12/19/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#ifndef Telehash_THInternal_h
#define Telehash_THInternal_h

#import "THNetwork.h"
#import "THExchange.h"
#import "THEvent.h"
#import "THChannel.h"

#include "../../telehash-c/include/e3x.h"

@interface THExchange()
{
  e3x_exchange_t _exchange;
}
@end

@interface THEvent()
{
  e3x_event_t _event;
}
@end

@interface THNetwork()
{
  e3x_self_t _network;
}
@property (readonly) e3x_self_t network;
@end

@interface THChannel()
{
  e3x_channel_t _channel;
}
@end

#endif
