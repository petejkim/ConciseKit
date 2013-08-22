#import <Foundation/Foundation.h>

@interface NSString (ConciseKit)

- (NSString *)appendPath:(NSString *)aString;
- (NSString *)append:(NSString *)aString;
- (NSString *)prepend:(NSString *)aString;
- (NSArray *)split:(NSString *)aString;
- (NSArray *)split;
- (NSString *)trim;
- (BOOL)equals:(NSString*)string;
- (BOOL)notEquals:(NSString*)string;

@end

@interface NSMutableString (ConciseKit)

- (NSMutableString *)append_:(NSString *)aString;
- (NSMutableString *)prepend_:(NSString *)aString;
- (NSMutableString *)insert:(NSString *)aString at:(NSUInteger)anIndex;
- (NSMutableString *)set:(NSString *)aString;

@end