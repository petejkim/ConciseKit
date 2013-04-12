#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSArrayConciseKit) {
  describe(@"NSArray (ConciseKit)", ^{
    __block NSArray *array;

    beforeEach(^{
      array = [NSArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$arr", ^{
      it(@"creates an array", ^{
        assertThat($arr(@"foo", @"bar", @"baz"), equalTo(array));
      });
    });

    describe(@"-$first", ^{
      it(@"returns the first object", ^{
        assertThat([array $first], equalTo(@"foo"));
      });
    });
    
    describe(@"-$first n", ^{
      it(@"should return first n objects from array", ^{
        assertThat([array $first:2], equalTo(@[@"foo", @"bar"]));
      });
    });

    describe(@"-$last", ^{
      it(@"returns the first object", ^{
        assertThat([array $last], equalTo(@"baz"));
      });
    });
      
    describe(@"-$all", ^{
      it(@"returns YES if all values of the array match the specification", ^{
        BOOL allValues = [$arr(@"ant", @"bear", @"cat") $all:^BOOL(NSString *obj) {
          return [obj length] >= 3;
        }];
          
        assertThatBool(allValues, equalToBool(YES));
      });
      
      it(@"returns NO if 1 or more values do not match the specification", ^{
        BOOL allValues = [$arr(@"ant", @"bear", @"cat") $all:^BOOL(NSString *obj) {
          return [obj length] >= 4;
        }];
        
        assertThatBool(allValues, equalToBool(NO));
      });
    });
    
    describe(@"-$any", ^{
      it(@"should return YES if one or more values match the specification", ^{
        BOOL anyValues = [$arr(@"ant", @"bear", @"cat") $any:^BOOL(NSString *obj) {
          return [obj length] >= 4;
        }];
        
        assertThatBool(anyValues, equalToBool(YES));
      });
      
      it(@"should return NO none of the values match the specification", ^{
        BOOL anyValues = [$arr(@"ant", @"bear", @"cat") $any:^BOOL(NSString *obj) {
          return [obj length] >= 5;
        }];
        
        assertThatBool(anyValues, equalToBool(NO));
      });
    });

    describe(@"-$at:", ^{
      it(@"returns the object at the given index", ^{
        assertThat([array $at:1], equalTo(@"bar"));
      });
    });
    
    describe(@"-$compact", ^{
      it(@"returns array with nulls removed", ^{
        NSArray *strippedArray = [[NSArray arrayWithObjects:@1, @2, [NSNull null], @3, nil] $compact];
        assertThat(strippedArray, equalTo(@[@1, @2, @3]));
      });
    });
    
    describe(@"-$concat", ^{
      it(@"should concatenate self with argument array", ^{
        NSArray *concatenatedArray = [array $concat:@[@3, @4]];

        assertThat(concatenatedArray, equalTo(@[@"foo", @"bar", @"baz", @3, @4]));
      });
    });

    describe(@"-$each:", ^{
      it(@"runs block for each item, passing the item as an argument", ^{
        __block NSInteger i=0;
        [$arr($integer(1), $integer(2), $integer(3)) $each:^(id obj) {
          i += [obj integerValue];
        }];
        assertThatInteger(i, equalToInteger(6));
      });
    });

    describe(@"-$eachWithIndex:", ^{
      it(@"runs block for each item, passing the item and its index as arguments", ^{
        __block NSInteger i=0;
        [$arr($integer(1), $integer(2), $integer(3)) $eachWithIndex:^(id obj, NSUInteger j) {
          i += [obj integerValue] + j;
        }];
        assertThatInteger(i, equalToInteger(9));
      });
    });

    describe(@"-$eachWithStop:", ^{
      it(@"runs block for each item, passing the item as an argument, until stop is set to YES", ^{
        __block NSInteger i=0;
        [$arr($integer(1), $integer(2), $integer(3)) $eachWithStop:^(id obj, BOOL *stop) {
          i += [obj integerValue];
          if([obj integerValue] == 2) {
            *stop = YES;
          }
        }];
        assertThatInteger(i, equalToInteger(3));
      });
    });

    describe(@"-$eachWithIndexAndStop:", ^{
      it(@"runs block for each item, passing the item and its index as arguments, until stop is set to YES", ^{
        __block NSInteger i=0;
        [$arr($integer(1), $integer(2), $integer(3)) $eachWithIndexAndStop:^(id obj, NSUInteger j, BOOL *stop) {
          i += [obj integerValue] + j;
          if([obj integerValue] == 2) {
            *stop = YES;
          }
        }];
        assertThatInteger(i, equalToInteger(4));
      });
    });
    
    describe(@"-$empty", ^{
      it(@"should return YES if there are no objects in the array", ^{
        NSArray *emptyArray = [NSArray array];
        assertThatBool([emptyArray $empty], equalToBool(YES));
      });
      
      it(@"should return NO if there are an objects in array", ^{
        NSArray *nonEmptyArray = @[@1];
        assertThatBool([nonEmptyArray $empty], equalToBool(NO));
      });
    });
    
    describe(@"-$include", ^{
      it(@"should return YES if any obj in array passes the specification", ^{
        BOOL included = [array $include:@"bar"];
        assertThatBool(included, equalToBool(YES));
      });
      
      it(@"should return NO if no obj in array passes the specification", ^{
        BOOL included = [array $include:@"trent"];
        assertThatBool(included, equalToBool(NO));
      });
    });

    describe(@"-$map:", ^{
      it(@"runs block for each item, passing the item as an argument, and creates a new array containing the return values of the block", ^{
        array = [$arr($integer(1), $integer(2), $integer(3)) $map:^(id obj) {
          return (id)$integer([obj integerValue] * 2);
        }];
        assertThat(array, equalTo($arr($integer(2), $integer(4), $integer(6))));
      });
    });

    describe(@"-$mapWithIndex:", ^{
      it(@"runs block for each item, passing the item and its index as arguments and creates a new array containing the return values of the block", ^{
        array = [$arr($integer(1), $integer(2), $integer(3)) $mapWithIndex:^(id obj, NSUInteger j) {
          return (id)$integer([obj integerValue] * 2 + j);
        }];
        assertThat(array, equalTo($arr($integer(2), $integer(5), $integer(8))));
      });
    });

    describe(@"-$reduce:", ^{
      it(@"runs a block for each item, passing in a memoized value and the item, reassigning the memoized value from the return value of each iteration, finally returning the last return value", ^{
        NSNumber *result = [$arr($integer(1), $integer(2), $integer(3), $integer(4)) $reduce:^(NSNumber *memo, NSNumber *obj) {
          return $integer([memo integerValue] + [obj integerValue]);
        }];
        assertThat(result, equalTo($integer(10)));
      });
    });

    describe(@"-$reduceStartingAt:with:", ^{
      it(@"performs a reduce function with a starting value", ^{
        NSNumber *result = [$arr($integer(10), $integer(2), $integer(3)) $reduceStartingAt:$integer(1) with:^(NSNumber *memo, NSNumber *obj) {
          return $integer([memo integerValue] * [obj integerValue]);
        }];
        assertThat(result, equalTo($integer(60)));
      });
    });

    describe(@"-$select:", ^{
      it(@"creates a subarray from elements where the block returns YES", ^{
        array = [$arr($integer(1), $integer(2), $integer(3), $integer(4)) $select:^BOOL(NSNumber *obj) {
          return ([obj integerValue] % 2) == 0;
        }];
        assertThat(array, equalTo($arr($integer(2), $integer(4))));
      });
    });

    describe(@"-$detect:", ^{
      it(@"returns the first value for which the block returns YES", ^{
        NSNumber *result = [$arr($integer(1), $integer(2), $integer(3)) $detect:^BOOL(NSNumber *obj) {
          return ([obj integerValue] % 2) == 1;
        }];
        assertThat(result, equalTo($integer(1)));
      });
    });

    describe(@"-$join", ^{
      it(@"joins the strings in the array without a separator, (more concise than componentsJoinedByString)", ^{
        assertThat([$arr(@"a", @"b", @"c") $join], equalTo(@"abc"));
      });
    });

    describe(@"-$join:", ^{
      it(@"joins the strings in the array with the supplied separator, (more concise than componentsJoinedByString)", ^{
        assertThat([$arr(@"a", @"b", @"c") $join:@"-"], equalTo(@"a-b-c"));
      });
    });
  });

  describe(@"NSMutableArray (ConciseKit)", ^{
    __block NSMutableArray *marray;

    beforeEach(^{
      marray = [NSMutableArray arrayWithObjects:@"foo", @"bar", @"baz", nil];
    });

    describe(@"$marr", ^{
      it(@"creates a mutable array", ^{
        NSMutableArray *newArray = $marr(@"foo", @"bar", @"baz");
        assertThat(newArray, equalTo(marray));
        [newArray addObject:@"lol"];
        assertThat(newArray, equalTo([NSArray arrayWithObjects:@"foo", @"bar", @"baz", @"lol", nil]));
      });
    });

    describe(@"$marrnew", ^{
      it(@"creates an empty mutable array", ^{
          NSMutableArray *newArray = $marrnew;
          assertThatInteger([newArray count], equalToInteger(0));
          [newArray addObject:@"lol"];
          assertThat(newArray, equalTo([NSArray arrayWithObject:@"lol"]));
      });
    });
    
    describe(@"-$drop", ^{
      it(@"should return a MutableArray with n objects removed from beginning of array", ^{
        NSMutableArray *droppedArray = [marray $drop:2];
        assertThat(droppedArray, equalTo(@[@"baz"]));
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
    
    describe(@"-$pop", ^{
      it(@"removes last object", ^{
        [marray $pop];
        assertThat([marray lastObject], equalTo(@"bar"));
      });
      
      it(@"returns last object", ^{
        assertThat([marray $pop], equalTo(@"baz"));
      });
    });
      
    describe(@"-$unshift:", ^{
      it(@"adds first object", ^{
        [marray $unshift:@"obj"];
        assertThat([marray objectAtIndex:0], equalTo(@"obj"));
      });
          
      it(@"returns self", ^{
        assertThat([marray $unshift:@"obj"], equalTo(marray));
      });
    });
      
    describe(@"-$shift", ^{
      it(@"removes first object", ^{
        [marray $shift];
        assertThat([marray objectAtIndex:0], equalTo(@"bar"));
      });
          
      it(@"returns first object", ^{
        assertThat([marray $shift], equalTo(@"foo"));
      });
    });
  });
}
DESCRIBE_END