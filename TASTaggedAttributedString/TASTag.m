//
//  TASTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASTag.h"

@implementation TASTag

- (TASAttribute *)attributeForTag
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)tagParsingClassName
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSRange)rangeForTag
{
    return NSMakeRange(self.startingLocation, self.endingLocation - self.startingLocation);
}

@end
