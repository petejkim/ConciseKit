/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "ConciseKit.h"
#import <objc/objc-class.h>

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

+ (BOOL)swizzleMethod:(SEL)originalSelector with:(SEL)anotherSelector inClass:(Class)klass {
  Method originalMethod = class_getInstanceMethod(klass, originalSelector);
  Method anotherMethod  = class_getInstanceMethod(klass, anotherSelector);
  if(!originalMethod || !anotherMethod) {
    return NO;
  }
  IMP originalMethodImplementation = class_getMethodImplementation(klass, originalSelector);
  IMP anotherMethodImplementation  = class_getMethodImplementation(klass, anotherSelector);
  if(class_addMethod(klass, originalSelector, originalMethodImplementation, method_getTypeEncoding(originalMethod))) {
    originalMethod = class_getInstanceMethod(klass, originalSelector);
  }
  if(class_addMethod(klass, anotherSelector,  anotherMethodImplementation,  method_getTypeEncoding(anotherMethod))) {
    anotherMethod = class_getInstanceMethod(klass, anotherSelector);
  }
  method_exchangeImplementations(originalMethod, anotherMethod);
  return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSelector with:(SEL)anotherSelector inClass:(Class)klass {
  Method originalMethod = class_getClassMethod(klass, originalSelector);
  Method anotherMethod  = class_getClassMethod(klass, anotherSelector);
  if(!originalMethod || !anotherMethod) {
    return NO;
  }
  IMP originalMethodImplementation = class_getMethodImplementation(klass, originalSelector);
  IMP anotherMethodImplementation  = class_getMethodImplementation(klass, anotherSelector);
  Class metaClass = objc_getMetaClass(class_getName(klass));
  if(class_addMethod(metaClass, originalSelector, originalMethodImplementation, method_getTypeEncoding(originalMethod))) {
    originalMethod = class_getClassMethod(klass, originalSelector);
  }
  if(class_addMethod(metaClass, anotherSelector,  anotherMethodImplementation,  method_getTypeEncoding(anotherMethod))) {
    anotherMethod = class_getClassMethod(klass, anotherSelector);
  }
  method_exchangeImplementations(originalMethod, anotherMethod);
  return YES;
}

@end

@implementation $
@end