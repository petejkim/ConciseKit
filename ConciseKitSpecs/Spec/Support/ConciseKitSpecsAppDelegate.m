#import <Cocoa/Cocoa.h>
#import <Cedar/Cedar.h>

@interface ConciseKitSpecsAppDelegate : NSObject {}
@end

@implementation ConciseKitSpecsAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  runAllSpecs();
  exit(0);
}

@end
