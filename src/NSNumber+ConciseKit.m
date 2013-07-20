#import "NSNumber+ConciseKit.h"

@implementation NSNumber (ConciseKit)

- (NSString *)$ordinal {
    int number = [self intValue];
    NSString *suffix = @"";
    int ones = number % 10;
    int tens = (int)floor(number / 10.0f) % 10;
    
    if (tens == 1) {
        suffix = @"th";
    } else if (ones == 1){
        suffix = @"st";
    } else if (ones == 2){
        suffix = @"nd";
    } else if (ones == 3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    return [NSString stringWithFormat:@"%i%@", number, suffix];
}

@end
