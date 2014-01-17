//
//  TASBackgroundColorTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASBackgroundColorTag.h"
#import "TASBackgroundColorParser.h"

@implementation TASBackgroundColorTag

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASBackgroundColorParser class]);
}

- (TASAttribute *)attributeForTag
{
    return [TASAttribute TASAttributeWithKey:NSBackgroundColorAttributeName
                                       value:self.color
                                       range:[self rangeForTag]];
}

@end
