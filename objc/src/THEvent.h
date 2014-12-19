//
//  THEvent.h
//  telehash
//
//  Created by David Waite on 10/14/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#ifndef telehash_THEvent_h
#define telehash_THEvent_h

@interface THEvent : NSObject
-(instancetype)init;

@property (readonly) uint32_t at;
//lob_t event3_get(event3_t ev); // has token and cid, look up and pass in to chan_receive
//void event3_set(event3_t ev, lob_t event, uint32_t at); // 0 is delete, event is unique per ->id
@end
#endif
