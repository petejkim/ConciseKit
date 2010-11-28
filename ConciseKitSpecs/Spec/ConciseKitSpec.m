#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE($) {
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
}
DESCRIBE_END