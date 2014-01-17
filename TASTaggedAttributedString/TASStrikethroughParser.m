//
//  TASStrikethroughParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 1/3/14.
//  Copyright (c) 2014 Sam Voigt. All rights reserved.
//

#import "TASStrikethroughParser.h"
#import "TASStrikethroughTag.h"

@implementation TASStrikethroughParser

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    if (openTag)
    {
        return nil;
    }
    TASParseResult *parseResult = [[TASParseResult alloc] init];
    parseResult.tag = [[TASStrikethroughTag alloc] init];
    return parseResult;
}

@end
