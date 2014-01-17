//
//  TASUnderlineParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASUnderlineParser.h"
#import "TASUnderlineTag.h"

@implementation TASUnderlineParser

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    if (openTag)
    {
        return nil;
    }
    TASParseResult *parseResult = [[TASParseResult alloc] init];
    parseResult.tag = [[TASUnderlineTag alloc] init];
    return parseResult;
}

@end
