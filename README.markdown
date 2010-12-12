# ConciseKit 0.0.1 - under heavy development

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

### waitUntil

Useful when writing tests for asynchronous tasks. Default timeout is 10 seconds, checking is done every 0.1 seconds.

        [$ waitUntil:^{ (BOOL)(someConditionIsMet == YES) }]
        [$ waitUntil:^{ (BOOL)(someConditionIsMet == YES) } timeOut:10.0]
        [$ waitUntil:^{ (BOOL)(someConditionIsMet == YES) } timeOut:10.0 interval:0.1]

## Macros

### General shorthands

        $new(Foo)       => [[[Foo alloc] init] autorelease]
        $eql(foo, bar)  => [foo isEqual:bar]

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

        $char(), $double(), $integer(), $long(), $longLong(), $short(), 
        $uChar(), $uInt(), $uInteger(), $uLong(), $uLongLong(), $uShort()

### NSValue shorthands
        $nonRetained(), $pointer(), $point(), $range(), $rect(), $size()

## Additions

### NSArray

        [array $first] => [array objectAtIndex:0]
        [array $last]  => [array lastObject]
        [array $at:1]  => [array objectAtIndex:1]

### NSMutableArray

        [array $push:foo] => [array addObject:foo] (+ returns self)

## License

Copyright (c) 2010 Peter Jihoon Kim. This code is licensed under the MIT License.