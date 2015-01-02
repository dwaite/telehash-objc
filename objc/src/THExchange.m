//
//  THExchange.m
//  telehash
//
//  Created by David Waite on 10/14/14.
//  Copyright (c) 2014 Alkaline Solutions. All rights reserved.
//

#import "THExchange.h"
#import "THNetwork.h"
#import "THPacket.h"
#import "THError.h"

#include "THInternal.inc"

@implementation THExchange

-(instancetype) initWithExchange: (e3x_exchange_t) exchange {
  if ((self = [super init])) {
    _exchange = exchange;
  }
  return self;
}
-(instancetype) initWithNetwork: (THNetwork *) network
                      cipherset: (THCipherSet) csid
                          inner: (NSData *)     inner {
  if ((self = [super init])) {
    lob_t lob = lob_parse(inner.bytes, inner.length);
    _exchange = e3x_exchange_new(network.network, csid, lob);
    lob_free (lob);
  }
  return self;
}

-(void) dealloc {
  e3x_exchange_free(_exchange);
}

-(NSData*) createMessage: (NSData*) inner {
  lob_t lob = lob_parse(inner.bytes, inner.length);
  lob_t msg = e3x_exchange_message(_exchange, lob);
  NSData *result = [NSData dataWithBytes: lob_raw(msg) length:lob_len(msg)];
  lob_free(lob);
  lob_free(msg);
  return result;
}

-(BOOL) verifyMessage:(NSData*) outer error: (NSError**) error {
  // 0 ok
  // 1 null parameter
  // 2 invalid header/csid
  // 3 ECDH failure
  // 4 crypto failure
  lob_t lob = lob_parse(outer.bytes, outer.length);
  e3x_cipher_remote_verify_error result = e3x_exchange_verify(_exchange, lob);
  lob_free(lob);
  switch (result) {
    case e3x_cipher_remote_verify_error_none:
      return YES;
    default:
      if (error)
        *error = [THError errorFromCryptoErrorCode: (NSInteger)result];
      return NO;
  }
}

-(THExchange*) sync: (NSData*) handshake {
  lob_t lob = lob_parse(handshake.bytes, handshake.length);
  e3x_exchange_t ex = e3x_exchange_sync(_exchange, lob );
  lob_free(lob);
  if (ex != NULL)
    return [[THExchange alloc] initWithExchange: ex];
  return nil;
}

-(NSData*) handshake {
  lob_t handshake = e3x_exchange_handshake(_exchange);
  NSData *result = [NSData dataWithBytes: lob_raw(handshake) length: lob_len(handshake)];
  lob_free(handshake);
  return result;
}

-(NSData*) receive: (NSData*) packet {
  lob_t pkt = lob_parse(packet.bytes, packet.length);
  lob_t lob = e3x_exchange_receive(_exchange, pkt);
  NSData* result = [NSData dataWithBytes:lob_raw(lob) length:lob_len(lob)];
  lob_free(lob);
  lob_free(pkt);
  return result;
}

-(NSData*) send: (NSData*) message {
  lob_t msg = lob_parse(message.bytes, message.length);
  lob_t lob = e3x_exchange_send(_exchange, msg);
  NSData* result = [NSData dataWithBytes: lob_raw(lob) length: lob_len(lob)];
  lob_free(msg);
  lob_free(lob);
  return result;
}

-(NSUInteger) channelId: (NSData*) incoming {
  lob_t lob = lob_parse(incoming.bytes, incoming.length);
  NSUInteger result = e3x_exchange_cid(_exchange, lob);
  lob_free(lob);
  return result;
}

-(NSData*) token {
  uint8_t *token = e3x_exchange_token(_exchange);
  return [NSData dataWithBytes:token length:16];
}
-(THAt) incomingAt {
  return e3x_exchange_in(_exchange, 0);
}

-(THAt) outgoingAt {
  return e3x_exchange_out(_exchange, 0);
}

-(void) setIncomingAt:(THAt)incomingAt {
  e3x_exchange_in(_exchange, incomingAt);
}

-(void) setOutgoingAt:(THAt)outgoingAt {
  e3x_exchange_out(_exchange, outgoingAt);
}

@end
