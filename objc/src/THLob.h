//
//  lob.h
//  
//
//  Created by David Waite on 10/13/14.
//
//

#include <stdint.h>
#include <stdlib.h>

#import <Foundation/Foundation.h>

@interface THLob : NSObject<NSCopying, NSSecureCoding>
+(BOOL)supportsSecureCoding;

-(id)init;
-(id)initWithData:(NSData *)data;
-(id)initWithCoder:(NSCoder *)decoder;
-(id)initWithCLob:(void*) lob;
-(id)copyWithZone:(NSZone *)zone;
-(void)dealloc;

- (void)encodeWithCoder:(NSCoder *)encoder;
-(void) append:(NSData *)chunk;
-(void) appendBytes:(const void *)chunk withLength: (NSUInteger) length;

-(BOOL)isEqual:(id) anObject;
-(BOOL)isEqualToLob:(THLob*) aLob;
-(NSUInteger) hash;

@property(readonly) const void* bytes;
@property(readonly) NSUInteger length;
@property(readonly) NSData* data;
@property(readonly) NSUInteger space;

@property(readonly) NSData* head;
@property(readonly) NSData* body;

@end
//typedef struct lob_struct
//{
//  uint8_t *raw;
//  uint8_t *body;
//  size_t body_len;
//  uint8_t *head;
//  size_t head_len;
//  struct lob_struct *next, *chain;
//  char *cache; // internal editable copy of the json
//  size_t quota; // defaults to 1440
//} *lob_t;
//
//// these all allocate/free memory
//lob_t lob_new();
//lob_t lob_copy(lob_t p);
//lob_t lob_free(lob_t p); // returns NULL for convenience
//// initialize head/body from raw, parses json
//lob_t lob_parse(uint8_t *raw, size_t len);
//
//// return full encoded packet
//uint8_t *lob_raw(lob_t p);
//size_t lob_len(lob_t p);
//
//// return current packet capacity based on quota
//size_t lob_space(lob_t p);
//
//// set/store these in the current packet
//uint8_t *lob_head(lob_t p, uint8_t *head, size_t len);
//uint8_t *lob_body(lob_t p, uint8_t *body, size_t len);
//void lob_append(lob_t p, uint8_t *chunk, size_t len);
//
//// convenient json setters/getters
//void lob_set_raw(lob_t p, char *key, char *val, size_t vlen); // raw
//void lob_set(lob_t p, char *key, char *val); // escapes value
//void lob_set_int(lob_t p, char *key, int val);
//void lob_set_printf(lob_t p, char *key, const char *format, ...);
//void lob_set_base32(lob_t p, char *key, uint8_t *val, size_t vlen);
//
//// copies keys from json into p
//void lob_set_json(lob_t p, lob_t json);
//
//// count of keys
//int lob_keys(lob_t p);
//
//// alpha sorts the json keys in the packet
//void lob_sort(lob_t p);
//
//// 0 to match, !0 if different, compares only top-level json and body
//int lob_cmp(lob_t a, lob_t b);
//
//// the return uint8_t* is invalidated with any _set* operation!
//char *lob_get(lob_t p, char *key);
//int lob_get_int(lob_t p, char *key);
//char *lob_get_index(lob_t p, uint32_t i); // returns ["0","1","2","3"]
//
//// returns new packets based on values
//lob_t lob_get_packet(lob_t p, char *key); // creates new packet from key:object value
//lob_t lob_get_packets(lob_t p, char *key); // list of packet->next from key:[object,object]
//lob_t lob_get_base32(lob_t p, char *key); // decoded binary is the return body
//
//// TODO, this would be handy, js syntax to get a json value
//// char *lob_eval(lob_t p, "foo.bar[0]['zzz']");
//
//#endif