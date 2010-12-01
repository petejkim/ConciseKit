/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSArrayConciseKit) {
  describe(@"NSArray (ConciseKit)", ^{
    __block NSArray *array;

    beforeEach(^{
      array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$arr", ^{
      it(@"creates array", ^{
        assertThat($arr(@"foo", @"bar", @"baz"), equalTo(array));
      });
    });

    describe(@"-$first", ^{
      it(@"returns the first object", ^{
        assertThat([array $first], equalTo(@"foo"));
      });
    });

    describe(@"-$last", ^{
      it(@"returns the first object", ^{
        assertThat([array $last], equalTo(@"baz"));
      });
    });

    describe(@"-$at:", ^{
      it(@"returns the object at given index", ^{
        assertThat([array $at:1], equalTo(@"bar"));
      });
    });
  });

  describe(@"NSMutableArray (ConciseKit)", ^{
    __block NSMutableArray *marray;

    beforeEach(^{
      marray = [NSMutableArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$marr", ^{
      it(@"creates mutable array", ^{
        NSMutableArray *marr = $marr(@"foo", @"bar", @"baz");
        assertThat(marr, equalTo(marray));
        [marr addObject:@"lol"];
        assertThat(marr, equalTo([NSArray arrayWithObjects:@"foo", @"bar", @"baz", @"lol", nil]));
      });
    });

    describe(@"-$push:", ^{
      it(@"adds an object", ^{
        [marray $push:@"obj"];
        assertThat([marray lastObject], equalTo(@"obj"));
      });

      it(@"returns self", ^{
        assertThat([marray $push:@"obj"], equalTo(marray));
      });
    });
  });
}
DESCRIBE_END