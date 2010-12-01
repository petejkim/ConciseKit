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

+ (BOOL)swizzleMethod:(SEL)originalSelector with:(SEL)anotherSelector inClass:(Class)klass;
+ (BOOL)swizzleClassMethod:(SEL)originalSelector with:(SEL)anotherSelector inClass:(Class)klass;

@end

@interface $ : ConciseKit {}
@end