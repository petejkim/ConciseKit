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

- (NSArray *)$each:(void (^)(id obj))block {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    block(obj);
  }];
  return self;
}

- (NSArray *)$eachWithIndex:(void (^)(id obj, NSUInteger idx))block {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    block(obj, idx);
  }];
  return self;
}

- (NSArray *)$eachWithStop:(void (^)(id obj, BOOL *stop))block {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    block(obj, stop);
  }];
  return self;
}

- (NSArray *)$eachWithIndexAndStop:(void (^)(id obj, NSUInteger idx, BOOL *stop))block {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    block(obj, idx, stop);
  }];
  return self;
}

- (NSArray *)$map:(id (^)(id obj))block {
  __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [array addObject:block(obj)];
  }];
  return array;
}

- (NSArray *)$mapWithIndex:(id (^)(id obj, NSUInteger idx))block {
  __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [array addObject:block(obj, idx)];
  }];
  return array;
}

- (id)$reduce:(id (^)(id memo, id obj))block {
  __block id ret = nil;
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (idx == 0) {
      ret = obj;
    } else {
      ret = block(ret, obj);
    }
  }];
  return ret;
}

- (id)$reduceStartingAt:(id)starting with:(id (^)(id memo, id obj))block {
  __block id ret = starting;
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    ret = block(ret, obj);
  }];
  return ret;
}

- (NSArray *)$select:(BOOL(^)(id obj))block {
  __block NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (block(obj)) {
      [array addObject:obj];
    }
  }];
  return [NSArray arrayWithArray:array];
}

- (id)$detect:(BOOL(^)(id obj))block {
  __block id ret = nil;
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (block(obj)) {
      *stop = YES;
      ret = obj;
    }
  }];
  return ret;
}

- (NSString *)$join {
  return [self componentsJoinedByString:@""];
}

- (NSString *)$join:(NSString *)separator {
  return [self componentsJoinedByString:separator];
}

@end

@implementation NSMutableArray (ConciseKit)

#ifndef __has_feature
    #define __has_feature(x) 0
#endif
#if __has_feature(objc_arc)
    #define IF_ARC(with, without) with
#else
    #define IF_ARC(with, without) without
#endif

- (NSMutableArray *)$push:(id)anObject {
  [self addObject:anObject];
  return self;
}

- (id)$pop; {
    IF_ARC(id lastObject = [self lastObject];, id lastObject = [[[self lastObject] retain] autorelease];)
    [self removeLastObject];
    return lastObject;
}

- (NSMutableArray *)$unshift:(id)anObject {
    [self insertObject:anObject atIndex:0];
    return self;
}

- (id)$shift; {
    IF_ARC(id firstObject = [self objectAtIndex:0];, id firstObject = [[[self objectAtIndex:0] retain] autorelease];)
    
    [self removeObjectAtIndex:0];
    return firstObject;
}

@end