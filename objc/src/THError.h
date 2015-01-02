//
//  THError.h
//  Telehash
//
//  Created by David Waite on 12/19/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#ifndef THError_h
#define THError_h

@import Foundation;

typedef NS_ENUM( NSInteger, THCryptoError) {
  THCryptoErrorNone = 0,
  THCryptoErrorNullParameter = 1,
  THCryptoErrorMalformedOuterPacket = 2,
  THCryptoErrorInvalidCiphersetIdentifier = 3,
  THCryptoErrorECDHFailure = 4,
  THCryptoErrorHMACFailure = 5
};

typedef NS_ENUM( NSInteger, THReceiveError) {
  THNilRequiredParameterError = 1
};

@interface THError : NSObject

+(NSError*) errorFromCryptoErrorCode: (THCryptoError)errorCode;
+(NSError*) errorFromReceiveErrorCode: (THReceiveError)errorCode;
@end

#endif
