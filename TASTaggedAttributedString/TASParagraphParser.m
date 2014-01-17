//
//  TASParagraphParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASParagraphParser.h"
#import "TASParagraphTag.h"

@implementation TASParagraphParser


+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    if ([command isEqualToString:kTASParagraphAlignmentKey])
    {
        return [TASParagraphParser parseAlignmentCommandWithargument:argument openTag:openTag];
    }
    return nil;
}

+ (TASParseResult *)parseAlignmentCommandWithargument:(NSString *)argument openTag:(TASTag *)openTag
{
    NSTextAlignment newAlignment;
    argument = [argument lowercaseString];
    
    if ([argument isEqualToString:@"right"])
    {
        newAlignment = NSTextAlignmentRight;
    }
    else if ([argument isEqualToString:@"center"])
    {
        newAlignment = NSTextAlignmentCenter;
    }
    else if ([argument isEqualToString:@"justified"])
    {
        newAlignment = NSTextAlignmentJustified;
    }
    else if ([argument isEqualToString:@"natural"])
    {
        newAlignment = NSTextAlignmentNatural;
    }
    else
    {
        newAlignment = NSTextAlignmentLeft;
    }
    
    if ([(TASParagraphTag *)openTag alignment] == newAlignment)
        return nil;
    
    TASParseResult *parseResult = [TASParseResult parseResultWithClosingTag:openTag];
    TASParagraphTag *tag = [[TASParagraphTag alloc] init];
    tag.alignment = newAlignment;
    parseResult.tag = tag;
    
    return parseResult;
}

@end
