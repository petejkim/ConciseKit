#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSDictionaryConciseKit) {
  describe(@"NSDictionary (ConciseKit)", ^{
    __block NSDictionary *dict;

    beforeEach(^{
      dict = [NSDictionary dictionaryWithObjectsAndKeys:@"bar", @"foo",
                                                        @"world", @"hello",
                                                        nil];
    });

    describe(@"$dict", ^{
      it(@"creates a dictionary", ^{
        assertThat($dict(@"bar", @"foo", @"world", @"hello"), equalTo(dict));
      });
    });

    describe(@"-$for:", ^{
      it(@"returns the object for the given key", ^{
        assertThat([dict for:@"foo"], equalTo(@"bar"));
      });
    });

    describe(@"-$keys:", ^{
      it(@"returns the keys for the dict", ^{
        assertThat([[dict keys] join], equalTo(@"foohello"));
      });
    });

    describe(@"-$values:", ^{
      it(@"returns the values for the dict", ^{
        assertThat([[dict values] join], equalTo(@"barworld"));
      });
    });

    describe(@"-$each:", ^{
      it(@"runs block for each key value pair, passing the key and value as arguments", ^{
        NSMutableArray *result = $marrnew;
        [dict each:^(id key, id value) {
          [result push:[key append:value]];
        }];
        assertThat([result first], equalTo(@"foobar"));
        assertThat([result last], equalTo(@"helloworld"));
      });
    });

    describe(@"-$eachWithStop:", ^{
      it(@"runs block for each key value pair, passing the key and value as an argument, until stop is set to YES", ^{
        NSMutableArray *result = $marrnew;
        [dict eachWithStop:^(id key, id value, BOOL *stop) {
          [result push:[key append:value]];
          if($eql(key, @"foo")) {
            *stop = YES;
          }
        }];
        assertThatInteger([result count], equalToInteger(1));
        assertThat([result last], equalTo(@"foobar"));
      });
    });

    describe(@"-$eachKey:", ^{
      it(@"runs block for each key, passing the key as an argument", ^{
        NSMutableArray *result = $marrnew;
        [dict eachKey:^(id key) {
          [result push:key];
        }];
        assertThat([result join], equalTo(@"foohello"));
      });
    });

    describe(@"-$eachValue:", ^{
      it(@"runs block for each value, passing the value as an argument", ^{
        NSMutableArray *result = $marrnew;
        [dict eachValue:^(id value) {
          [result push:value];
        }];
        assertThat([result join], equalTo(@"barworld"));
      });
    });
  });

  describe(@"NSMutableDictionary (ConciseKit)", ^{
    __block NSMutableDictionary *mdict;

    beforeEach(^{
      mdict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"bar", @"foo",
                                                                @"world", @"hello",
                                                                nil];
    });

    describe(@"$mdict", ^{
      it(@"creates a mutable dictionary", ^{
        NSMutableDictionary *newDict = $mdict(@"bar", @"foo", @"world", @"hello");
        assertThat(newDict, equalTo(mdict));
        [newDict setObject:@"qux" forKey:@"baz"];
        assertThat(newDict, equalTo([NSDictionary dictionaryWithObjectsAndKeys:@"bar", @"foo", @"world", @"hello", @"qux", @"baz", nil]));
      });
    });

    describe(@"$mdictnew", ^{
      it(@"creates an empty mutable dictionary", ^{
          NSMutableDictionary *newDict = $mdictnew;
          assertThatInteger([newDict count], equalToInteger(0));
          [newDict setObject:@"qux" forKey:@"baz"];
          assertThat(newDict, equalTo([NSDictionary dictionaryWithObjectsAndKeys:@"qux", @"baz", nil]));
      });
    });

    describe(@"-$obj:for:", ^{
      it(@"sets an object for a key", ^{
        [mdict obj:@"qux" for:@"baz"];
        assertThat([mdict objectForKey:@"baz"], equalTo(@"qux"));
      });

      it(@"returns self", ^{
        assertThat([mdict obj:@"qux" for:@"baz"], equalTo(mdict));
      });
    });
  });
}
DESCRIBE_END