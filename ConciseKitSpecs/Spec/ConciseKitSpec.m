/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "SpecHelper.h"
#import "ConciseKit.h"
#import "Foo.h"

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
    describe(@"+swizzleMethod:with:inClass:", ^{
      it(@"swizzles instances methods", ^{
        Foo *obj = [[Foo alloc] init];
        assertThat([obj foo], equalTo(@"-foo"));
        assertThat([obj bar], equalTo(@"-bar"));
        [$ swizzleMethod:@selector(foo) with:@selector(bar) inClass:[Foo class]];
        assertThat([obj foo], equalTo(@"-bar"));
        assertThat([obj bar], equalTo(@"-foo"));
        [$ swizzleMethod:@selector(foo) with:@selector(bar) inClass:[Foo class]];
        assertThat([obj foo], equalTo(@"-foo"));
        assertThat([obj bar], equalTo(@"-bar"));
        [obj release];
      });
    });

    describe(@"+swizzleClassMethod:with:inClass:", ^{
      it(@"swizzles class methods", ^{
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Foo bar], equalTo(@"+bar"));
        [$ swizzleClassMethod:@selector(foo) with:@selector(bar) inClass:[Foo class]];
        assertThat([Foo foo], equalTo(@"+bar"));
        assertThat([Foo bar], equalTo(@"+foo"));
        [$ swizzleClassMethod:@selector(foo) with:@selector(bar) inClass:[Foo class]];
        assertThat([Foo foo], equalTo(@"+foo"));
        assertThat([Foo bar], equalTo(@"+bar"));
      });
    });
  });
}
DESCRIBE_END