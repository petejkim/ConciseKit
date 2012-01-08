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
        assertThat([dict $for:@"foo"], equalTo(@"bar"));
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

    describe(@"-$obj:for:", ^{
      it(@"sets an object for a key", ^{
        [mdict $obj:@"qux" for:@"baz"];
        assertThat([mdict objectForKey:@"baz"], equalTo(@"qux"));
      });

      it(@"returns self", ^{
        assertThat([mdict $obj:@"qux" for:@"baz"], equalTo(mdict));
      });
    });
  });
}
DESCRIBE_END