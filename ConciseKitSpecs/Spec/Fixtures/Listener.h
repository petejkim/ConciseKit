#import <Foundation/Foundation.h>

@interface Listener : NSObject
@property (readwrite) BOOL notificationWasReceived;
@property (nonatomic, strong) NSObject * objectReceivedViaNotification;

-(void)receiveNotification;
-(void)receiveNotification:(NSNotification*)notification;
@end
