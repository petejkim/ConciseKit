/* ConciseKit
 * Copyright 2010 Peter Jihoon Kim
 * Licensed under the MIT License.
 */
#define $shared(Klass) [Klass shared##Klass]

#ifdef ALLOW_ALLOC_INIT_FOR_SINGLETONS
  #define $singleton(Klass)\
  \
  static Klass *shared##Klass = nil;\
  \
  + (Klass *)shared##Klass {\
    @synchronized(self) {\
      if(shared##Klass == nil) {\
        shared##Klass = [[super allocWithZone:NULL] initSingleton];\
      }\
    }\
    return shared##Klass;\
  }\
  \
  - (id)init {\
    if((self = [super init])) {\
      [self initSingleton];\
    }\
    return self;\
  }
#else
  #define $singleton(Klass)\
  \
  static Klass *shared##Klass = nil;\
  \
  + (Klass *)shared##Klass {\
    @synchronized(self) {\
      if(shared##Klass == nil) {\
        shared##Klass = [[super allocWithZone:NULL] init];\
      }\
    }\
    return shared##Klass;\
  }\
  \
  + (id)allocWithZone:(NSZone *)zone {\
    return [[self shared##Klass] retain];\
  }\
  \
  - (id)copyWithZone:(NSZone *)zone {\
    return self;\
  }\
  \
  - (id)retain {\
    return self;\
  }\
  \
  - (NSUInteger)retainCount {\
    return NSUIntegerMax;\
  }\
  \
  - (void)release {}\
  \
  - (id)autorelease {\
    return self;\
  }\
  \
  + (BOOL)isShared##Klass##Present {\
    return shared##Klass != nil;\
  }\
  \
  - (id)init {\
    if(![[self class] isShared##Klass##Present]) {\
      if((self = [super init])) {\
        [self initSingleton];\
      }\
    }\
    return self;\
  }
#endif