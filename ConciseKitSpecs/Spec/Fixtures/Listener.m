#import "Listener.h"

@implementation Listener
@synthesize notificationWasReceived,objectReceivedViaNotification;
-(void)receiveNotification{
    self.notificationWasReceived = YES;
}
-(void)receiveNotification:(NSNotification *)notification{
    [self receiveNotification];
    self.objectReceivedViaNotification = notification.object;
}
@end
