#import "Foo.h"

@implementation Foo
+ (NSString *)foo { return @"+foo"; }
+ (NSString *)bar { return @"+bar"; }
- (NSString *)foo { return @"-foo"; }
- (NSString *)bar { return @"-bar"; }
@end

@implementation SubFoo
+ (NSString *)bar { return @"+SubFoo::bar"; }
- (NSString *)bar { return @"-SubFoo::bar"; }
@end

@implementation Bar
+ (NSString *)bar { return @"+Bar::bar"; }
- (NSString *)bar { return @"-Bar::bar"; }
@end