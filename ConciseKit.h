/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import <Foundation/Foundation.h>
#import "CKMacros.h"
#import "CKAdditions.h"

@interface ConciseKit : NSObject {}

+ (NSString *)homePath;
+ (NSString *)desktopPath;
+ (NSString *)documentPath;
+ (NSString *)appPath;

@end

@interface $ : ConciseKit {}
@end