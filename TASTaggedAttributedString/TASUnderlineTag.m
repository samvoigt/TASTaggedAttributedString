//
//  TASUnderlineTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASUnderlineTag.h"
#import "TASUnderlineParser.h"

@implementation TASUnderlineTag

- (TASAttribute *)attributeForTag
{
    return [TASAttribute TASAttributeWithKey:NSUnderlineStyleAttributeName
                                       value:@(NSUnderlineStyleSingle)
                                       range:[self rangeForTag]];
}

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASUnderlineParser class]);
}

@end
