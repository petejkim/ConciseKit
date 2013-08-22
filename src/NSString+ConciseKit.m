#import "NSString+ConciseKit.h"

@implementation NSString (ConciseKit)

- (NSString *)appendPath:(NSString *)aString {
    return [self stringByAppendingPathComponent:aString];
}

- (NSString *)append:(NSString *)aString {
  return [self stringByAppendingString:aString];
}

- (NSString *)prepend:(NSString *)aString {
  return [NSString stringWithFormat:@"%@%@", aString, self];
}

- (NSArray *)split:(NSString *)aString {
  return [self componentsSeparatedByString:aString];
}

- (NSArray *)split {
    return [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)equals:(NSString*)string {
    return [self isEqualToString:string];
}

- (BOOL)notEquals:(NSString*)string {
    return ![self equals:string];
}

@end

@implementation NSMutableString (ConciseKit)

- (NSMutableString *)append_:(NSString *)aString {
  [self appendString:aString];
  return self;
}

- (NSMutableString *)prepend_:(NSString *)aString {
  [self insertString:aString atIndex:0];
  return self;
}

- (NSMutableString *)insert:(NSString *)aString at:(NSUInteger)anIndex {
  [self insertString:aString atIndex:anIndex];
  return self;
}

- (NSMutableString *)set:(NSString *)aString {
  [self setString:aString];
  return self;
}

@end