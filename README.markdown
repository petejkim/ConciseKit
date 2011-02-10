# ConciseKit 0.0.1

A set of Objective-C additions and macros that lets you to write code more quickly.

## $ class

### Method Swizzling

        [$ swizzleMethod:@selector(foo) with:@selector(bar) in:[Foo class]]
        [$ swizzleMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]]

        [$ swizzleClassMethod:@selector(foo) with:@selector(bar) in:[Foo class]]
        [$ swizzleClassMethod:@selector(foo) in:[Foo class] with:@selector(bar) in:[Bar class]]

### Path

        [$ homePath]     => path to user's home directory
        [$ desktopPath]  => path to user's desktop directory
        [$ documentPath] => path to user's document directory
        [$ appPath]      => path to app directory
        [$ resourcePath] => path to app's resources directory

### waitUntil

Useful when writing tests for asynchronous tasks. Default timeout is 10 seconds, checking is done every 0.1 seconds.

        [$ waitUntil:^{ return (BOOL)(someConditionIsMet == YES) }]
        [$ waitUntil:^{ return (BOOL)(someConditionIsMet == YES) } timeOut:10.0]
        [$ waitUntil:^{ return (BOOL)(someConditionIsMet == YES) } timeOut:10.0 interval:0.1]

## Singleton

### Creating Singletons

        @interface Foo
        - (id)initSingleton; // <= add these to the interface
        + (Foo *)sharedFoo;  // <= where Foo is the class name
        @end

        @implementation Foo
        $singleton(Foo);     // => makes Foo a singleton class

        - (id)initSingleton {
          foo = 1;           // do initialization in -initSingleton method
          bar = 2;
          return self;
        }
        @end

### Using Singletons

        $shared(Foo)         // => returns the shared instance
        /* or */
        [Foo sharedFoo]

## Macros

### General shorthands

        $new(Foo)       => [[[Foo alloc] init] autorelease]
        $eql(foo, bar)  => [foo isEqual:bar]
        $safe(obj)      => (obj == [NSNull null] ? nil : obj)

### NSArray shorthands

        $arr(foo, bar)   =>  [NSArray arrayWithObjects:foo, bar, nil]
        $marr(foo, bar)  =>  [NSMutableArray ...]

### NSSet shorthands

        $set(foo, bar)   =>  [NSSet setWithObjects:foo, bar, nil]
        $mset(foo, bar)  =>  [NSMutableSet ...]

### NSDictionary shorthands

        $dict(v1, k1, v2, k2)  => [NSDictionary dictionaryWithObjectsAndKeys:v1, k1, v2, k2, nil]
        $mdict(v1, k1, v2, k2) => [NSMutableDictionary ...]

### NSString shorthands

        $str(@"foo: %@", bar)   => [NSString stringWithFormat:@"foo: %@", bar]
        $mstr(@"foo: %@", bar)  => [NSMutableString ...]

### NSNumber shorthands

        $bool(YES)    => [NSNumber numberWithBool:YES]
        $int(123)     => [NSNumber numberWithInt:123]
        $float(123.4) => [NSNumber numberWithFloat:123.4]

        $char(), $double(), $integer(), $long(), $longlong(), $short(),
        $uchar(), $uint(), $uinteger(), $ulong(), $ulonglong(), $ushort()

### NSValue shorthands
        $nonretained(), $pointer(), $point(), $range(), $rect(), $size()

## Additions

### NSArray

        [array $first] => [array objectAtIndex:0]
        [array $last]  => [array lastObject]
        [array $at:1]  => [array objectAtIndex:1]

        [array $each:^(id obj) {
          NSLog(@"%@", obj);
        }]

        [array $eachWithIndex:^(id obj, NSUInteger i) {
          NSLog(@"%d %@", i, obj);
        }]

        [array $eachWithStop:^(id obj, BOOL *stop) {
          NSLog(@"%@", obj);
          if($eql(obj, @"foo")) {
            *stop = YES;
          }
        }]

        [array $eachWithIndexAndStop:^(id obj, NSUInteger i, BOOL *stop) {
          NSLog(@"%d %@", i, obj);
          if(i == 1) {
            *stop = YES;
          }
        }]

        [array $map:^(id obj) {
          return $integer([obj integerValue] * 2);
        }]

        [array $mapWithIndex:^(id obj, NSUInteger i) {
          return $integer([obj integerValue] * 2 + i);
        }]

### NSMutableArray

        [array $push:foo] => [array addObject:foo] (+ returns self)

### NSDictionary

        [dict $for:@"foo"] => [dict objectForKey:@"foo"]

### NSMutableDictionary

        [dict $obj:@"bar" for:@"foo"] => [dict setObject:@"bar" forKey:@"foo"] (+ returns self)

### NSString

        [string $append:@"foo"]  => [string stringByAppendString:@"foo"]
        [string $prepend:@"foo"] => [NSString stringWithFormat:@"%@%@", @"foo", string]
        [string $split:@","]     => [string componentsSeparatedByString:@","]

### NSMutableString

        [string $append_:@"foo"]     => [string appendString:@"foo"]           (+ returns self)
        [string $prepend_:@"foo"]    => [string insertString:@"foo" atIndex:0] (+ returns self)
        [string $insert:@"foo" at:1] => [string insertString:@"foo" atIndex:1] (+ returns self)
        [string $set:@"foo"]         => [string setString:@"foo"]              (+ returns self)

## License

Copyright (c) 2010 Peter Jihoon Kim. This code is licensed under the MIT License.