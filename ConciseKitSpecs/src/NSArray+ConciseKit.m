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

@end

@implementation NSMutableArray (ConciseKit)

- (NSMutableArray *)$push:(id)anObject {
  [self addObject:anObject];
  return self;
}

@end