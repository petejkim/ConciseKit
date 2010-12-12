/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
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

@end

@interface NSMutableArray (ConciseKit)

- (NSMutableArray *)$push:(id)anObject;

@end