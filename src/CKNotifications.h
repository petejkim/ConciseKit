#import <Foundation/Foundation.h>

static __inline__ void
$listen(NSString * eventName, NSObject * target, SEL action)
{
	[[NSNotificationCenter defaultCenter] addObserver:target selector:action name:eventName object:nil];
}

static __inline__ void
$notify(NSString * eventName){
	[[NSNotificationCenter defaultCenter] postNotificationName:eventName object:nil];
}
static __inline__ void
$notifyWithObject(NSString * eventName, __strong NSObject * object){
	[[NSNotificationCenter defaultCenter] postNotificationName:eventName object:object];
}