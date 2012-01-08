#import <Foundation/Foundation.h>

@interface CKMocks : NSObject {}

+ (void)resetAll;
+ (void)resetForSelector:(SEL)selector in:(Class)klass;
+ (NSArray *)callsForSelector:(SEL)selector in:(Class)klass;
+ (NSUInteger)callCountForSelector:(SEL)selector in:(Class)klass;

@end
