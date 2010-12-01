/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "NSArray+ConciseKit.h"

@implementation NSArray (ConciseKit)

- (id)$first {
  return [self objectAtIndex:0];
}

- (id)$last {
  return [self lastObject];
}

- (id)$at:(NSUInteger)index {
  return [self objectAtIndex:index];
}

@end

@implementation NSMutableArray (ConciseKit)

- (id)$push:(id)anObject {
  [self addObject:anObject];
  return self;
}

@end