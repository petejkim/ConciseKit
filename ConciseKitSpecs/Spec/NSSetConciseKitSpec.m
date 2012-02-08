#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSSetConciseKit) {
  describe(@"NSSet (ConciseKit)", ^{
    __block NSSet *set;

    beforeEach(^{
        set = [NSSet setWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$set", ^{
        it(@"creates a set", ^{
            assertThat($set(@"foo", @"bar", @"baz"), equalTo(set));
        });
    });
  });

  describe(@"NSMutableSet (ConciseKit)", ^{
    __block NSMutableSet *mset;

    beforeEach(^{
        mset = [NSMutableSet setWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$mset", ^{
      it(@"creates a mutable set", ^{
          NSMutableSet *mset = $mset(@"foo", @"bar", @"baz");
          assertThat(mset, equalTo(mset));
          [mset addObject:@"lol"];
          assertThat(mset, equalTo([NSSet setWithObjects:@"foo", @"bar", @"baz", @"lol", nil]));
      });
    });

    describe(@"$msetnew", ^{
      it(@"creates an empty mutable set", ^{
          NSMutableSet *newSet = $msetnew;
          assertThatInteger([newSet count], equalToInteger(0));
          [newSet addObject:@"lol"];
          assertThat(newSet, equalTo([NSSet setWithObjects:@"lol", nil]));
      });
    });
  });
}
DESCRIBE_END