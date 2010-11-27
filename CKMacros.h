/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#define $new(Klass) [[[Klass alloc] init] autorelease]
#define $eql(a,b)   [(a) isEqual:(b)]

#define $arr(...)   [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define $marr(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define $set(...)   [NSSet setWithObjects:__VA_ARGS__, nil]
#define $mset(...)  [NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define $dict(...)  [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $mdict(...) [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define $str(...)   [NSString stringWithFormat:__VA_ARGS__]
#define $mstr(...)  [NSMutableString stringWithFormat:__VA_ARGS__]

#define $bool(val)      [NSNumber numberWithBool:(val)]
#define $char(val)      [NSNumber numberWithChar:(val)]
#define $double(val)    [NSNumber numberWithDouble:(val)]
#define $float(val)     [NSNumber numberWithFloat:(val)]
#define $int(val)       [NSNumber numberWithInt:(val)]
#define $integer(val)   [NSNumber numberWithInteger:(val)]
#define $long(val)      [NSNumber numberWithLong:(val)]
#define $longLong(val)  [NSNumber numberWithLongLong:(val)]
#define $short(val)     [NSNumber numberWithShort:(val)]
#define $uChar(val)     [NSNumber numberWithUnsignedChar:(val)]
#define $uInt(val)      [NSNumber numberWithUnsignedInt:(val)]
#define $uInteger(val)  [NSNumber numberWithUnsignedInteger:(val)]
#define $uLong(val)     [NSNumber numberWithUnsignedLong:(val)]
#define $uLongLong(val) [NSNumber numberWithUnsignedLongLong:(val)]
#define $uShort(val)    [NSNumber numberWithUnsignedShort:(val)]

#define $nonRetained(val) [NSValue valueWithNonretainedObject:(val)]
#define $pointer(val)     [NSValue valueWithPointer:(val)]
#define $point(val)       [NSValue valueWithPoint:(val)]
#define $range(val)       [NSValue valueWithRange:(val)]
#define $rect(val)        [NSValue valueWithRect:(val)]
#define $size(val)        [NSValue valueWithSize:(val)]
