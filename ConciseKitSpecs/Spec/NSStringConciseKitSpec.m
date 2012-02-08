#import "SpecHelper.h"
#import "ConciseKit.h"

DESCRIBE(NSStringConciseKit) {
  describe(@"NSString (ConciseKit)", ^{
    __block NSString *string;

    beforeEach(^{
      string = @"foo";
    });

    describe(@"$str", ^{
      it(@"creates a string using a given format", ^{
        assertThat($str(@"%@%@", @"foo", @"bar"), equalTo(@"foobar"));
      });
    });

    describe(@"-$append", ^{
      it(@"appends another string", ^{
        assertThat([string $append:@"bar"], equalTo(@"foobar"));
      });
    });

    describe(@"-$prepend", ^{
      it(@"prepends another string", ^{
        assertThat([string $prepend:@"bar"], equalTo(@"barfoo"));
      });
    });

    describe(@"-$split:", ^{
      it(@"divides string into an array of strings by a given string", ^{
        assertThat([@"f,o,o" $split:@","], equalTo($arr(@"f",@"o",@"o")));
      });
    });

    describe(@"-$split", ^{
      it(@"divides string into an array of strings using whitespace", ^{
        assertThat([@"ab cd ef" $split], equalTo($arr(@"ab",@"cd",@"ef")));
      });
    });
  });

  describe(@"NSMutableString (ConciseKit)", ^{
    __block NSMutableString *mstring;

    beforeEach(^{
      mstring = [NSMutableString stringWithString:@"foo"];
    });

    describe(@"$mstr", ^{
      it(@"creates a mutable string using a given format", ^{
        mstring = $mstr(@"%@%@", @"foo", @"bar");
        assertThat(mstring, equalTo(@"foobar"));
        [mstring appendString:@"baz"];
        assertThat(mstring, equalTo(@"foobarbaz"));
      });
    });

    describe(@"$mstrnew", ^{
      it(@"creates an empty mutable string", ^{
          NSMutableString *newString = $mstrnew;
          assertThatInteger([newString length], equalToInteger(0));
          [newString appendString:@"lol"];
          assertThat(newString, equalTo(@"lol"));
      });
    });

    describe(@"-$append_", ^{
      it(@"appends another string and returns self", ^{
        assertThat([mstring $append_:@"bar"], equalTo(@"foobar"));
      });
    });

    describe(@"-$prepend_", ^{
      it(@"prepends another string and returns self", ^{
        assertThat([mstring $prepend_:@"bar"], equalTo(@"barfoo"));
        assertThat(mstring, equalTo(@"barfoo"));
      });
    });

    describe(@"-$insert:at:", ^{
      it(@"inserts a string at given position and returns self", ^{
        assertThat([mstring $insert:@"bar" at:1], equalTo(@"fbaroo"));
        assertThat(mstring, equalTo(@"fbaroo"));
      });
    });

    describe(@"-$set:", ^{
      it(@"sets the mutable string to be given string", ^{
        assertThat([mstring $set:@"bar"], equalTo(@"bar"));
        assertThat(mstring, equalTo(@"bar"));
      });
    });
  });
}
DESCRIBE_END