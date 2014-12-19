//
//  THNetwork.h
//  
//
//  Created by David Waite on 10/13/14.
//
//

#import <Foundation/Foundation.h>

@class THExchange;
@class THLob;

@interface THNetwork :NSObject

+(void) initialize;
+(void) reinitializeWithOptions: (NSDictionary*) options error: (NSError**) error;

+(NSString*) lastError;
+(NSData*) generateSecrets;

-(instancetype) initWithSecrets: (NSData*) secrets andKeys: (NSData*) keys;
-(void) dealloc;

-(THLob*) decryptMessage: (NSData*) message;
@property (readwrite) NSDate *lastHandshake;
@end