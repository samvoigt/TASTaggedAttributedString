//
//  TASParagraphTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASParagraphTag.h"
#import "TASParagraphParser.h"

@implementation TASParagraphTag

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASParagraphParser class]);
}

- (TASAttribute *)attributeForTag
{
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setAlignment:self.alignment];
    
    return [TASAttribute TASAttributeWithKey:NSParagraphStyleAttributeName
                                       value:paragraphStyle
                                       range:[self rangeForTag]];
}

@end
