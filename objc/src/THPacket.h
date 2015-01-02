//
//  lob.h
//  
//
//  Created by David Waite on 10/13/14.
//
//

#include <stdint.h>
#include <stdlib.h>

@import Foundation;

@class THMutablePacket;

@interface THPacket : NSObject<NSCopying, NSMutableCopying, NSSecureCoding>

-(instancetype)init NS_DESIGNATED_INITIALIZER;
-(instancetype)initWithData:(NSData *)data;
-(instancetype)initWithCLob:(void*) lob;
-(instancetype)initWithJSONHeader:(NSDictionary*) head body: (NSData*) body;
-(instancetype)initWithBinaryHeader:(NSData*) head body: (NSData*) body;

#pragma mark NSSecureCoding
-(instancetype)initWithCoder:(NSCoder *)decoder NS_DESIGNATED_INITIALIZER;
-(void)encodeWithCoder:(NSCoder *)encoder;
+(BOOL)supportsSecureCoding;

#pragma mark NSCopying , NSMutableCopying
-(THPacket*)copyWithZone:(NSZone *)zone;
-(THMutablePacket*)mutableCopyWithZone:(NSZone*)zone;

#pragma mark NSObject
-(BOOL)isEqual:(id) anObject;
-(NSUInteger) hash;

//@property(readonly) const void* bytes;
//@property(readonly) NSUInteger length;
//@property(readonly) NSData* data;
//@property(readonly) NSUInteger space;

@property(readonly) BOOL          hasJSONHeader;
@property(readonly) NSData*       binaryHeader;
@property(readonly) NSDictionary* jsonHeader;
@property(readonly) NSData*       body;
@end

@interface THMutablePacket : THPacket<NSCopying, NSMutableCopying, NSSecureCoding>
@property(readonly)  NSMutableData       *binaryHeader;
@property(readonly)  NSMutableDictionary *jsonHeader;
@property(readonly)  NSMutableData       *body;
@property(readwrite) BOOL                 hasJSONHeader;
@end