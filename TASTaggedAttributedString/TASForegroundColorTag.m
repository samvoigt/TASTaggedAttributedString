//
//  TASForegroundColorTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASForegroundColorTag.h"
#import "TASForegroundColorParser.h"

@implementation TASForegroundColorTag

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASForegroundColorParser class]);
}

- (TASAttribute *)attributeForTag
{
    return [TASAttribute TASAttributeWithKey:NSForegroundColorAttributeName
                                       value:self.color
                                       range:[self rangeForTag]];
}

@end
