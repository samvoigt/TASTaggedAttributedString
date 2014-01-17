//
//  TASStrikethroughTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 1/3/14.
//  Copyright (c) 2014 Sam Voigt. All rights reserved.
//

#import "TASStrikethroughTag.h"
#import "TASStrikethroughParser.h"

@implementation TASStrikethroughTag

- (TASAttribute *)attributeForTag
{
    return [TASAttribute TASAttributeWithKey:NSStrikethroughStyleAttributeName
                                       value:@(NSUnderlineStyleSingle)
                                       range:[self rangeForTag]];
}

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASStrikethroughParser class]);
}

@end
