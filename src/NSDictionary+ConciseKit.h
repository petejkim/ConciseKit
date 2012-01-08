#import <Foundation/Foundation.h>

@interface NSDictionary (ConciseKit)

- (id)$for:(id)aKey;

@end

@interface NSMutableDictionary (ConciseKit)

- (NSMutableDictionary *)$obj:(id)anObject for:(id)aKey;

@end