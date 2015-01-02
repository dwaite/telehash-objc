//
//  NSString_NSString_Base32_m.h
//  telehash
//
//  Created by David Waite on 12/18/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

@import Foundation;

@interface NSData (Base32)
-(instancetype) initWithBase32EncodedString: (NSString*) encodedString;
-(instancetype) initWithBase32EncodedData: (NSData*) encodedData;

-(NSString*) base32EncodedString;
-(NSData*) base32EncodedData;
@end
