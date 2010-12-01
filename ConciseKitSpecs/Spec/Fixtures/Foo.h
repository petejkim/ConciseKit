/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import <Foundation/Foundation.h>

@interface Foo : NSObject {}
+ (NSString *)foo;
+ (NSString *)bar;
- (NSString *)foo;
- (NSString *)bar;
@end

@interface SubFoo : Foo {}
@end

@interface Bar : NSObject {}
+ (NSString *)bar;
- (NSString *)bar;
@end