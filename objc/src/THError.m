//
//  TelehashErrors.m
//  Telehash
//
//  Created by David Waite on 12/19/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THError.h"
#import "THInternal.inc"

static NSDictionary *telehashErrors;

@implementation THError
+(void) initialize {
  telehashErrors = @{
    @0 : NSLocalizedString(@"THCryptoErrorNone",
                           @"No error"),
    @1 : NSLocalizedString(@"THCryptoErrorNullParameter",
                           @"Required parameter is nil"),
    @2 : NSLocalizedString(@"THCryptoErrorMalformedOuterPacket",
                           @"Malformed Outer Packet"),
    @3 : NSLocalizedString(@"THCryptoErrorInvalidCiphersetIdentifier",
                           @"Invalid Cipherset Identifier"),
    @4 : NSLocalizedString(@"THCryptoErrorECDHFailure",
                           @"Failure deriving key via ECDH"),
    @5 : NSLocalizedString(@"THCryptoErrorHMACFailure",
                           @"Cryptography failure during HMAC")
  };
}

+(NSError*) errorFromCryptoErrorCode: (THCryptoError)errorCode {
  NSString * errorText = telehashErrors[@((NSInteger)errorCode)];
  if (errorText == nil)
    return nil;
  return [NSError errorWithDomain: @"Telehash"
                             code: (NSInteger)errorCode
                         userInfo: @{
                                     NSLocalizedDescriptionKey: errorText,
                                     NSLocalizedFailureReasonErrorKey: errorText
        }];
}

@end