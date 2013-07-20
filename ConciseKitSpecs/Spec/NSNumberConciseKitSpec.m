#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSNumberConciseKit) {
    describe(@"NSNumber (ConciseKit)", ^{
        __block NSNumber *number;
        
        beforeEach(^{
            number = [NSNumber numberWithInt:1];
        });
        
        describe(@"$ordinal", ^{
            it(@"gives the ordinal representation of a number", ^{
                assertThat([number $ordinal], equalTo(@"1st"));
                assertThat([@2 $ordinal], equalTo(@"2nd"));
                assertThat([@3 $ordinal], equalTo(@"3rd"));
                assertThat([@4 $ordinal], equalTo(@"4th"));
                assertThat([@11 $ordinal], equalTo(@"11th"));
                assertThat([@101 $ordinal], equalTo(@"101st"));
                assertThat([@111 $ordinal], equalTo(@"111th"));
            });
        });
    });
}
DESCRIBE_END