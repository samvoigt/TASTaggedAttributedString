/*
 NSString+TaggedAttributedString.m
 
 Created by Samuel Voigt on 10/16/13.
 Copyright (c) 2013 Sam Voigt. All rights reserved.
 
 */

#import "NSString+TaggedAttributedString.h"
#import "TASStringToAttributedStringParser.h"

@implementation NSString (TaggedAttributedString)

- (NSAttributedString *)attributedStringFromTaggedString
{
    return [[[TASStringToAttributedStringParser alloc] init] parseTaggedString:self parameters:nil];
}

- (NSAttributedString *)attributedStringFromTaggedStringWithFontsAndColors:(id)firstParameter,...
{
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    id eachParameter;
    va_list parameterList;
    if (firstParameter)
    {
        [parameters addObject: firstParameter];
        va_start(parameterList, firstParameter);
        while ((eachParameter = va_arg(parameterList, id)))
            [parameters addObject: eachParameter];
        va_end(parameterList);
    }
        
    return [[[TASStringToAttributedStringParser alloc] init] parseTaggedString:self parameters:parameters];
}

@end



