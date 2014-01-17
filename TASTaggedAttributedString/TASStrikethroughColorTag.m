//
//  TASStrikethroughColorTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 1/3/14.
//  Copyright (c) 2014 Sam Voigt. All rights reserved.
//

#import "TASStrikethroughColorTag.h"
#import "TASStrikethroughColorParser.h"

@implementation TASStrikethroughColorTag

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASStrikethroughColorParser class]);
}

- (TASAttribute *)attributeForTag
{
    return [TASAttribute TASAttributeWithKey:NSStrikethroughColorAttributeName
                                       value:self.color
                                       range:[self rangeForTag]];
}

@end
