/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "ConciseKit.h"

@implementation ConciseKit

+ (NSString *)homePath {
  return NSHomeDirectory();
}

+ (NSString *)desktopPath {
  return [NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)documentPath {
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString *)appPath {
  return [[NSBundle mainBundle] bundlePath];
}

@end

@implementation $
@end