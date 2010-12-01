/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "Foo.h"

@implementation Foo
+ (NSString *)foo { return @"+foo"; }
+ (NSString *)bar { return @"+bar"; }
- (NSString *)foo { return @"-foo"; }
- (NSString *)bar { return @"-bar"; }
@end