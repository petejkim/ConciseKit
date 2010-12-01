/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "SpecHelper.h"
#import "ConciseKit.h"
#import "Foo.h"
#import <objc/objc-class.h>

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
        [foo release];
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
          [foo release];
          [subFoo release];
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
        [foo release];
        [bar release];
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
}
DESCRIBE_END