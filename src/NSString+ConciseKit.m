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

- (NSArray *)$split {
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)$chop {
    return [self substringToIndex:[self length] - 1];
}

- (NSString *)$capitalize {
    return [self capitalizedString];
}

- (NSString *)$downcase {
    return [self lowercaseString];
}

- (NSString *)$upcase {
    return [self uppercaseString];
}

- (NSString *)$mult:(NSUInteger)times {
    NSString *string = @"";
    for (int i = 0; i < times; i++)
        string = [string $append:self];
    return string;
}

- (NSString *)$center:(NSUInteger)width {
    int add = width - [self length];
    if (add > 0) {
        CGFloat half = add / 2;
        NSString *evenPad = [@"" stringByPaddingToLength:(int)half withString:@" " startingAtIndex:0];
        NSString *oddPad = [@"" stringByPaddingToLength:(int)half + 1 withString:@" " startingAtIndex:0];
        if ((add % 2) == 0)
            self = [self $append:evenPad];
        else
            self = [self $append:oddPad];
        
        self = [self $prepend:evenPad];
    }
    return self;
}

- (NSString *)$center:(NSUInteger)width str:(NSString *)aString {
    int add = width - [self length];
    if (add > 0) {
        CGFloat half = add / 2;
        NSString *evenPad = [@"" stringByPaddingToLength:(int)half withString:aString startingAtIndex:0];
        NSString *oddPad = [@"" stringByPaddingToLength:(int)half + 1 withString:aString startingAtIndex:0];
        if ((add % 2) == 0)
            self = [self $append:evenPad];
        else
            self = [self $append:oddPad];
        
        self = [self $prepend:evenPad];
    }
    return self;
}

- (BOOL)$includes:(NSString *)aString {
    if ([self rangeOfString:aString].location == NSNotFound)
        return NO;
    return YES;
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