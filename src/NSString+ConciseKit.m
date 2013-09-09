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

- (BOOL)$isBlank {
    return ([self length] == 0);
}

- (NSInteger)$indexOf:(NSString *)theSubString from:(NSInteger)theFrom {
    NSRange theRange = NSMakeRange(theFrom, self.length - theFrom);
    
	NSRange theIndex = [self rangeOfString:theSubString options:NSLiteralSearch range:theRange];
	if (theIndex.location == NSNotFound) {
		return -1;
	}
	return theIndex.location + theIndex.length;
}

- (NSString *)$substringFrom:(NSInteger)theFrom to:(NSInteger)theTo {
	NSRange theRange = NSMakeRange(theFrom, theTo - theFrom);
	return [self substringWithRange:theRange];
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