#import "CKMocks.h"
#import "ConciseKit.h"

static NSMutableDictionary *dict;

@interface CKMocks (PrivateMethods)

+ (NSString *)keyForSelector:(SEL)selector in:(Class)klass;
+ (void)addReceivedValues:(NSArray *)values forSelector:(SEL)selector in:(Class)klass;

@end

@implementation CKMocks

+ (void)initialize {
  dict = [[NSMutableDictionary alloc] init];
}

+ (NSString *)keyForSelector:(SEL)selector in:(Class)klass {
  return $str(@"[%@ %@]", NSStringFromClass(klass), NSStringFromSelector(selector));
}

+ (void)addReceivedValues:(NSArray *)values forSelector:(SEL)selector in:(Class)klass {
  NSString *key = [self keyForSelector:selector in:klass];
  if([dict objectForKey:key] == nil) {
    [dict setObject:$marr(nil) forKey:key];
  }
  [(NSMutableArray *)[dict objectForKey:key] push:values];
}

+ (void)resetAll {
  [dict removeAllObjects];
}

+ (void)resetForSelector:(SEL)selector in:(Class)klass {
  [dict removeObjectForKey:[self keyForSelector:selector in:klass]];
}

+ (NSArray *)callsForSelector:(SEL)selector in:(Class)klass {
  NSArray *values = [dict objectForKey:[self keyForSelector:selector in:klass]];
  if(values == nil) {
    return $arr(nil);
  }
  return values;
}

+ (NSUInteger)callCountForSelector:(SEL)selector in:(Class)klass {
  NSArray *values = [dict objectForKey:[self keyForSelector:selector in:klass]];
  if(values == nil) {
    return 0;
  }
  return [values count];
}

@end

@interface CKMocks (MockMethods)
// ConciseKit
+ (void)waitUntil:(BOOL (^)(void))condition timeOut:(NSTimeInterval)timeOut interval:(NSTimeInterval)interval;
@end

@implementation CKMocks (MockMethods)
// ConciseKit
+ (void)waitUntil:(BOOL (^)(void))condition timeOut:(NSTimeInterval)timeOut interval:(NSTimeInterval)interval {
  [CKMocks addReceivedValues:$arr(condition, $double(timeOut), $double(interval)) forSelector:@selector(waitUntil:timeOut:interval:) in:[$ class]];
}
@end