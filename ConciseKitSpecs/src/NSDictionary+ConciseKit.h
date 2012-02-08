#import <Foundation/Foundation.h>

@interface NSDictionary (ConciseKit)

- (id)$for:(id)aKey;
- (NSArray *)$keys;
- (NSArray *)$values;
- (NSDictionary *)$each:(void (^)(id key, id value))block;
- (NSDictionary *)$eachWithStop:(void (^)(id key, id value, BOOL *stop))block;
- (NSDictionary *)$eachKey:(void (^)(id key))block;
- (NSDictionary *)$eachValue:(void (^)(id value))block;

@end

@interface NSMutableDictionary (ConciseKit)

- (NSMutableDictionary *)$obj:(id)anObject for:(id)aKey;

@end