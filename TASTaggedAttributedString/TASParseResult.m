//
//  TASParseResult.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASParseResult.h"
#import "TASTag.h"

@implementation TASParseResult

+ (TASParseResult *)parseResultWithClosingTag:(TASTag *)closingTag
{
    TASParseResult *parseResult = [[TASParseResult alloc] init];
    parseResult.closingTag = closingTag;
    return parseResult;
}

@end
