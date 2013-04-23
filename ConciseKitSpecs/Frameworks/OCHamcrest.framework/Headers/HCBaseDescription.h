//
//  OCHamcrest - HCBaseDescription.h
//  Copyright 2009 www.hamcrest.org. See LICENSE.txt
//
//  Created by: Jon Reid
//

    // Inherited
#import <Foundation/Foundation.h>
#import "HCDescription.h"


/**
    Base class for all HCDescription implementations.
*/
@interface HCBaseDescription : NSObject<HCDescription>
@end


/**
    Methods that must be provided by subclasses of HCBaseDescription.
*/
@interface HCBaseDescription (SubclassMustImplement)

/**
    Append the string @a str to the description.
*/
- (void) append:(NSString*)str;

@end
