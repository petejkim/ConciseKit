/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "NSDictionary+ConciseKit.h"

@implementation NSDictionary (ConciseKit)

- (id)$for:(id)aKey {
  return [self objectForKey:aKey];
}

@end

@implementation NSMutableDictionary (ConciseKit)

- (NSMutableDictionary *)$obj:(id)anObject for:(id)aKey {
  [self setObject:anObject forKey:aKey];
  return self;
}

@end
