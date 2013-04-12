#import <Foundation/Foundation.h>

@interface NSArray (ConciseKit)

- (id)$first;
- (NSArray *)$first:(int)n;
- (id)$last;
- (BOOL)$all:(BOOL (^)(id obj))block;
- (BOOL)$any:(BOOL (^)(id obj))block;
- (id)$at:(NSUInteger)index;
- (NSArray *)$compact;
- (NSArray *)$concat:(NSArray *)otherArray;
- (NSArray *)$each:(void (^)(id obj))block;
- (NSArray *)$eachWithIndex:(void (^)(id obj, NSUInteger idx))block;
- (NSArray *)$eachWithStop:(void (^)(id obj, BOOL *stop))block;
- (NSArray *)$eachWithIndexAndStop:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
- (BOOL)$empty;
- (BOOL)$include:(id)obj;
- (NSArray *)$map:(id (^)(id obj))block;
- (NSArray *)$mapWithIndex:(id (^)(id obj, NSUInteger idx))block;
- (id)$reduce:(id (^)(id memo, id obj))block;
- (id)$reduceStartingAt:(id)starting with:(id (^)(id memo, id obj))block;
- (NSArray *)$select:(BOOL(^)(id obj))block;
- (id)$detect:(BOOL(^)(id obj))block;
- (NSString *)$join;
- (NSString *)$join:(NSString *)separator;

@end

@interface NSMutableArray (ConciseKit)

- (NSMutableArray *)$drop:(int)n;
- (NSMutableArray *)$push:(id)anObject;
- (id)$pop;
- (NSArray *)$replace:(NSArray *)otherArray;
- (id)$shift;
- (NSMutableArray *)$unshift:(id)anObject;

@end