#import "NSData_Base32.h"
#include "../../telehash-c/include/base32.h"

@implementation NSData (Base32)

-(instancetype) initWithBase32EncodedString: (NSString*) encodedString {
  NSData * encodedData = [encodedString dataUsingEncoding: NSUTF8StringEncoding];
  return [self initWithBase32EncodedData: encodedData];
}

-(instancetype) initWithBase32EncodedData: (NSData*) encodedData {
  size_t len = base32_decode_length(encodedData.length);
  if (len > 0) {
    void* data = malloc(len);
    base32_decode_into(encodedData.bytes, encodedData.length, data);
    return [self initWithBytesNoCopy: data length:len];
  }
  return nil;
}

-(NSString*) base32EncodedString {
  size_t encodedLength = base32_encode_length(self.length);
  void * encodedData = malloc(encodedLength);
  if (encodedData) {
    base32_encode_into(self.bytes, self.length, encodedData);
  }
  return [[NSString alloc] initWithBytesNoCopy: encodedData length: encodedLength encoding:NSUTF8StringEncoding freeWhenDone: YES];
}

-(NSData*) base32EncodedData {
  size_t encodedLength = base32_encode_length(self.length);
  void * encodedData = malloc(encodedLength);
  if (encodedData) {
    base32_encode_into(self.bytes, self.length, encodedData);
  }
  return [[NSData alloc] initWithBytesNoCopy: encodedData length: encodedLength];
}

@end
