//
//  THNetwork.m
//  
//
//  Created by David Waite on 10/13/14.
//
//

#import "THNetwork.h"
#import "THExchange.h"
#import "THLob.h"

#import "../../telehash-c/include/e3x.h"

@interface THNetwork()
@property (readonly) e3x_self_t network;
@end

@implementation THNetwork

+(void) initialize {
  e3x_init(NULL);
}

+(void) reinitializeWithOptions: (NSDictionary*) options error: (NSError**) error {
  NSData *data = [NSJSONSerialization dataWithJSONObject: options options: 0 error: error];
  if (data != nil)
    e3x_init(lob_parse((const uint8_t*)data.bytes, data.length));
}

+(NSString*) lastError {
  return [NSString stringWithUTF8String: (const char*)e3x_err()];
}

+(NSData*) generateSecrets {
  lob_t secrets = e3x_generate();
  return [NSData dataWithBytes: lob_raw(secrets) length: lob_len(secrets)];
}

-(instancetype) initWithSecrets: (NSData*) secrets andKeys: (NSData*) keys {
  if (self = [super init]) {
    _network = e3x_self_new(
        lob_parse((const uint8_t*)secrets.bytes, secrets.length),
                            lob_parse((const uint8_t*)keys.bytes, keys.length));
    if (_network == nil)
      return nil;
  }
  return self;
}

-(void) dealloc {
  e3x_self_free(_network);
}

-(THLob*) decryptMessage: (NSData*) message {
  lob_t decrypted = e3x_self_decrypt(_network, lob_parse((const uint8_t*)message.bytes, message.length));
  return [[THLob alloc ]initWithCLob: decrypted];
}

@end
