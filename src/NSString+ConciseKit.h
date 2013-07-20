#import <Foundation/Foundation.h>

@interface NSString (ConciseKit)

- (NSString *)$append:(NSString *)aString;
- (NSString *)$prepend:(NSString *)aString;
- (NSArray *)$split:(NSString *)aString;
- (NSArray *)$split;
- (NSString *)$mult:(NSUInteger)times;
- (NSString *)$capitalize;
- (NSString *)$downcase;
- (NSString *)$upcase;
- (NSString *)$center:(NSUInteger)width;
- (NSString *)$center:(NSUInteger)width str:(NSString *)aString;
- (NSString *)$chop;
- (BOOL)$includes:(NSString *)aString;



@end

@interface NSMutableString (ConciseKit)

- (NSMutableString *)$append_:(NSString *)aString;
- (NSMutableString *)$prepend_:(NSString *)aString;
- (NSMutableString *)$insert:(NSString *)aString at:(NSUInteger)anIndex;
- (NSMutableString *)$set:(NSString *)aString;

@end