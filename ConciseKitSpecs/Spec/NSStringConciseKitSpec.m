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
      
    describe(@"-$chop", ^{
      it(@"removes the last letter in the string", ^{
          assertThat([@"string" $chop], equalTo(@"strin"));
          assertThat([@"a" $chop], equalTo(@""));
          assertThat([@"string\n" $chop], equalTo(@"string"));
      });
    });

    describe(@"-$capitalize", ^{
      it(@"capitalizes the first character", ^{
          assertThat([@"aBc2" $capitalize], equalTo(@"Abc2"));
      });
    });

    describe(@"-$downcase", ^{
      it(@"makes every character lowercase", ^{
          assertThat([@"ABc2" $downcase], equalTo(@"abc2"));
      });
    });
      
    describe(@"-$upcase", ^{
      it(@"makes every character uppercase", ^{
          assertThat([@"aBc2" $upcase], equalTo(@"ABC2"));
      });
    });
      
    describe(@"-$mult:", ^{
      it(@"copies a string a specific number of times", ^{
          assertThat([@"abc" $mult:0], equalTo(@""));
          assertThat([@"abc" $mult:1], equalTo(@"abc"));
          assertThat([@"abc" $mult:4], equalTo(@"abcabcabcabc"));
      });
    });

    describe(@"-$center:", ^{
      it(@"centers string in width of spaces", ^{
          assertThat([@"hello" $center:20], equalTo(@"       hello        "));
          assertThat([@"hello" $center:4], equalTo(@"hello"));
      });
    });

    describe(@"-$center:str:", ^{
      it(@"centers string in specified width centered and padded with str", ^{
          assertThat([@"hello" $center:20 str:@"123"], equalTo(@"1231231hello12312312"));
          assertThat([@"hello" $center:15 str:@"123"], equalTo(@"12312hello12312"));
          assertThat([@"hello" $center:4 str:@"123"], equalTo(@"hello"));
      });
    });

    describe(@"-$includes:", ^{
      it(@"determines whether or not this string is included", ^{
          assert([@"abcdef" $includes:@"bcd"]);
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