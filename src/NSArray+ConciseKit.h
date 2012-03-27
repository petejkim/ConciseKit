#import <Foundation/Foundation.h>

@interface NSArray (ConciseKit)

- (id)$first;
- (id)$last;
- (id)$at:(NSUInteger)index;
- (NSArray *)$each:(void (^)(id obj))block;
- (NSArray *)$eachWithIndex:(void (^)(id obj, NSUInteger idx))block;
- (NSArray *)$eachWithStop:(void (^)(id obj, BOOL *stop))block;
- (NSArray *)$eachWithIndexAndStop:(void (^)(id obj, NSUInteger idx, BOOL *stop))block;
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

- (NSMutableArray *)$push:(id)anObject;
- (id)$pop;
- (NSMutableArray *)$unshift:(id)anObject;
- (id)$shift;

@end