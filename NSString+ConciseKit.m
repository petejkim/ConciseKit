/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "NSString+ConciseKit.h"

@implementation NSString (ConciseKit)

- (NSString *)$append:(NSString *)aString {
  return [self stringByAppendingString:aString];
}

- (NSString *)$prepend:(NSString *)aString {
  return [NSString stringWithFormat:@"%@%@", aString, self];
}

- (NSArray *)$split:(NSString *)aString {
  return [self componentsSeparatedByString:aString];
}

@end

@implementation NSMutableString (ConciseKit)

- (NSMutableString *)$append_:(NSString *)aString {
  [self appendString:aString];
  return self;
}

- (NSMutableString *)$prepend_:(NSString *)aString {
  [self insertString:aString atIndex:0];
  return self;
}

- (NSMutableString *)$insert:(NSString *)aString at:(NSUInteger)anIndex {
  [self insertString:aString atIndex:anIndex];
  return self;
}

- (NSMutableString *)$set:(NSString *)aString {
  [self setString:aString];
  return self;
}

@end