/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import <Foundation/Foundation.h>
#import "CKMacros.h"
#import "CKAdditions.h"
#import "CKSingleton.h"

@interface ConciseKit : NSObject {}

+ (NSString *)homePath;
+ (NSString *)desktopPath;
+ (NSString *)documentPath;
+ (NSString *)appPath;
+ (NSString *)resourcePath;

+ (BOOL)swizzleMethod:(SEL)originalSelector with:(SEL)anotherSelector in:(Class)klass;
+ (BOOL)swizzleMethod:(SEL)originalSelector in:(Class)klass with:(SEL)anotherSelector in:(Class)anotherKlass;
+ (BOOL)swizzleClassMethod:(SEL)originalSelector with:(SEL)anotherSelector in:(Class)klass;
+ (BOOL)swizzleClassMethod:(SEL)originalSelector in:(Class)klass with:(SEL)anotherSelector in:(Class)anotherKlass;

+ (void)waitUntil:(BOOL (^)(void))condition;
+ (void)waitUntil:(BOOL (^)(void))condition timeOut:(NSTimeInterval)timeOut;
+ (void)waitUntil:(BOOL (^)(void))condition timeOut:(NSTimeInterval)timeOut interval:(NSTimeInterval)interval;

@end

@interface $ : ConciseKit {}
@end