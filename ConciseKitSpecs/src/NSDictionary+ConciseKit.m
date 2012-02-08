#import "NSDictionary+ConciseKit.h"

@implementation NSDictionary (ConciseKit)

- (id)$for:(id)aKey {
  return [self objectForKey:aKey];
}

- (NSArray *)$keys {
    return [self allKeys];
}

- (NSArray *)$values {
    return [self allValues];
}

- (NSDictionary *)$each:(void (^)(id key, id value))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        block(key, value);
    }];
    return self;
}

- (NSDictionary *)$eachWithStop:(void (^)(id key, id value, BOOL *stop))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        block(key, value, stop);
    }];
    return self;
}

- (NSDictionary *)$eachKey:(void (^)(id key))block {
    [[self allKeys] enumerateObjectsUsingBlock:^(id key, NSUInteger idx, BOOL *stop) {
        block(key);
    }];
    return self;
}

- (NSDictionary *)$eachValue:(void (^)(id value))block {
    [[self allValues] enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL *stop) {
        block(value);
    }];
    return self;
}

@end

@implementation NSMutableDictionary (ConciseKit)

- (NSMutableDictionary *)$obj:(id)anObject for:(id)aKey {
  [self setObject:anObject forKey:aKey];
  return self;
}

@end
