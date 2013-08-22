#import "SpecHelper.h"
#import "ConciseKit.h"
#import "Foo.h"
#import "CKMocks.h"

#if __has_feature(objc_arc)
    #define ARCLESS(block)
#else
    #define ARCLESS(block) block
#endif

DESCRIBE($) {
  describe(@"path", ^{
    describe(@"+homePath", ^{
      it(@"returns the user's home directory", ^{
        assertThat([$ homePath], equalTo([@"~" stringByExpandingTildeInPath]));
      });
    });

    describe(@"+desktopPath", ^{
      it(@"returns the user's desktop directory", ^{
        assertThat([$ desktopPath], equalTo([@"~/Desktop" stringByExpandingTildeInPath]));
      });
    });

    describe(@"+documentPath", ^{
      it(@"returns the user's document directory", ^{
        assertThat([$ documentPath], equalTo([@"~/Documents" stringByExpandingTildeInPath]));
      });
    });

    describe(@"+appPath", ^{
      it(@"returns the app's directory", ^{
        assertThat([$ appPath], endsWith(@"ConciseKitSpecs.app"));
      });
    });

    describe(@"+resourcePath", ^{
      it(@"returns the app's directory", ^{
        assertThat([$ resourcePath], endsWith(@"ConciseKitSpecs.app/Contents/Resources"));
      });
    });
  });

  describe(@"method swizzling", ^{
    describe(@"+swizzleMethod:with:in:", ^{
      it(@"swizzles instance methods", ^{
        Foo *foo = [[Foo alloc] init];
        assertThat([foo foo], equalTo(@"-foo"));
        assertThat([foo bar], equalTo(@"-bar"));
        [$ swizzleMethod:@selector(foo) with:@selector(bar) in:[Foo class]];
        assertThat([foo foo], equalTo(@"-bar"));
        assertThat([foo bar], equalTo(@"-foo"));
        [$ swizzleMethod:@selector(foo) with:@selector(bar) in:[Foo class]];
        assertThat([foo foo], equalTo(@"-foo"));
        assertThat([foo bar], equalTo(@"-bar"));
        ARCLESS([foo release]);
      });

      context(@"swizzling inherited methods", ^{
        it(@"adds the inherited methods to the subclass and then swizzles, preserving the original method in superclass", ^{
          Foo *foo = [[Foo alloc] init];
          SubFoo *subFoo = [[SubFoo alloc] init];
          assertThat([foo foo],    equalTo(@"-foo"));
          assertThat([subFoo foo], equalTo(@"-foo"));
          assertThat([subFoo bar], equalTo(@"-SubFoo::bar"));
          [$ swizzleMethod:@selector(foo) with:@selector(bar) in:[SubFoo class]];
          assertThat([foo foo],    equalTo(@"-foo"));
          assertThat([subFoo foo], equalTo(@"-SubFoo::bar"));
          assertThat([subFoo bar], equalTo(@"-foo"));
          [$ swizzleMethod:@selector(foo) with:@selector(bar) in:[SubFoo class]];
          assertThat([foo foo],    equalTo(@"-foo"));
          assertThat([subFoo foo], equalTo(@"-foo"));
          assertThat([subFoo bar], equalTo(@"-SubFoo::bar"));
          ARCLESS([foo release]);
          ARCLESS([subFoo release]);
        });
      });
    });

    describe(@"+swizzleMethod:in:with:in:", ^{
      it(@"swizzles instance methods", ^{
        Foo *foo = [[Foo alloc] init];
        Bar *bar = [[Bar alloc] init];
        assertThat([foo foo], equalTo(@"-foo"));
        assertThat([bar bar], equalTo(@"-Bar::bar"));
        [$ swizzleMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]];
        assertThat([foo foo], equalTo(@"-Bar::bar"));
        assertThat([bar bar], equalTo(@"-foo"));
        [$ swizzleMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]];
        assertThat([foo foo], equalTo(@"-foo"));
        assertThat([bar bar], equalTo(@"-Bar::bar"));
        ARCLESS([foo release]);
        ARCLESS([bar release]);
      });
    });

    describe(@"+swizzleClassMethod:with:in:", ^{
      it(@"swizzles class methods", ^{
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Foo bar], equalTo(@"+bar"));
        [$ swizzleClassMethod:@selector(foo) with:@selector(bar) in:[Foo class]];
        assertThat([Foo foo], equalTo(@"+bar"));
        assertThat([Foo bar], equalTo(@"+foo"));
        [$ swizzleClassMethod:@selector(foo) with:@selector(bar) in:[Foo class]];
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Foo bar], equalTo(@"+bar"));
      });

      context(@"swizzling inherited class methods", ^{
        it(@"adds the inherited class methods to the subclass and then swizzles, preserving the original method in superclass", ^{
          assertThat([Foo foo],    equalTo(@"+foo"));
          assertThat([SubFoo foo], equalTo(@"+foo"));
          assertThat([SubFoo bar], equalTo(@"+SubFoo::bar"));
          [$ swizzleClassMethod:@selector(foo) with:@selector(bar) in:[SubFoo class]];
          assertThat([Foo foo],    equalTo(@"+foo"));
          assertThat([SubFoo foo], equalTo(@"+SubFoo::bar"));
          assertThat([SubFoo bar], equalTo(@"+foo"));
          [$ swizzleClassMethod:@selector(foo) with:@selector(bar) in:[SubFoo class]];
          assertThat([Foo foo],    equalTo(@"+foo"));
          assertThat([SubFoo foo], equalTo(@"+foo"));
          assertThat([SubFoo bar], equalTo(@"+SubFoo::bar"));
        });
      });
    });

    describe(@"+swizzleClassMethod:in:with:in:", ^{
      it(@"swizzles class methods", ^{
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Bar bar], equalTo(@"+Bar::bar"));
        [$ swizzleClassMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]];
        assertThat([Foo foo], equalTo(@"+Bar::bar"));
        assertThat([Bar bar], equalTo(@"+foo"));
        [$ swizzleClassMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]];
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Bar bar], equalTo(@"+Bar::bar"));
      });
    });
  });

  describe(@"waitUntil", ^{
    __block BOOL (^condition)(void);

    beforeEach(^{
      [CKMocks resetAll];
      condition = ^{
        return YES;
      };
    });

    describe(@"+waitUntil:timeOut:interval:", ^{
      it(@"waits until condition is met", ^{
        __block BOOL performed = NO;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          performed = YES;
        }];
        assertThatBool(performed, equalToBool(NO));
        [$ waitUntil:^{ return (BOOL)(performed == YES); } timeOut:10.0 interval:0.1];
        assertThatBool(performed, equalToBool(YES));
      });
    });

    describe(@"+waitUntil:timeOut:", ^{
      it(@"calls +waitUntil:timeOut:interval: with interval=0.1", ^{
        [$ swizzleClassMethod:@selector(waitUntil:timeOut:interval:) in:[$ class] with:@selector(waitUntil:timeOut:interval:) in:[CKMocks class]];
        [$ waitUntil:condition timeOut:20.0];
        NSArray *array = [CKMocks callsForSelector:@selector(waitUntil:timeOut:interval:) in:[$ class]];
        assertThatUnsignedInteger([array count], equalToUnsignedInteger(1));
        assertThat([array at:0], equalTo($arr(condition, $double(20.0), $double(0.1))));
        [$ swizzleClassMethod:@selector(waitUntil:timeOut:interval:) in:[$ class] with:@selector(waitUntil:timeOut:interval:) in:[CKMocks class]];
      });
    });

    describe(@"+waitUntil:", ^{
      it(@"calls +waitUntil:timeOut:interval: with timeOut=10.0, interval=0.1", ^{
        [$ swizzleClassMethod:@selector(waitUntil:timeOut:interval:) in:[$ class] with:@selector(waitUntil:timeOut:interval:) in:[CKMocks class]];
        [$ waitUntil:condition];
        NSArray *array = [CKMocks callsForSelector:@selector(waitUntil:timeOut:interval:) in:[$ class]];
        assertThatUnsignedInteger([array count], equalToUnsignedInteger(1));
        assertThat([array at:0], equalTo($arr(condition, $double(10.0), $double(0.1))));
        [$ swizzleClassMethod:@selector(waitUntil:timeOut:interval:) in:[$ class] with:@selector(waitUntil:timeOut:interval:) in:[CKMocks class]];
      });
    });
  });

  describe(@"$safe", ^{
    NSNull *n = [NSNull null];
    assertThat($safe(n), nilValue());
    NSString *foo = @"foo";
    assertThat($safe(foo), equalTo(@"foo"));
  });
}
DESCRIBE_END