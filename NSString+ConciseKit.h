/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import <Foundation/Foundation.h>

@interface NSString (ConciseKit)

- (NSString *)$append:(NSString *)aString;
- (NSString *)$prepend:(NSString *)aString;
- (NSArray *)$split:(NSString *)aString;

@end

@interface NSMutableString (ConciseKit)

- (NSMutableString *)$append_:(NSString *)aString;
- (NSMutableString *)$prepend_:(NSString *)aString;
- (NSMutableString *)$insert:(NSString *)aString at:(NSUInteger)anIndex;
- (NSMutableString *)$set:(NSString *)aString;

@end