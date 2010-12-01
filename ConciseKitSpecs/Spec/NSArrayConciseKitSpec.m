/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSArrayConciseKit) {
  describe(@"-firstObject", ^{
    it(@"returns the first object", ^{
      NSArray *array = [NSArray arrayWithObjects:@"foo", @"bar", nil];
      assertThat([array firstObject], equalTo([array objectAtIndex:0]));
    });
  });
}
DESCRIBE_END