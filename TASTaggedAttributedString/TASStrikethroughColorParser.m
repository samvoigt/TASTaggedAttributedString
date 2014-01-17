//
//  TASStrikethroughColorParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 1/3/14.
//  Copyright (c) 2014 Sam Voigt. All rights reserved.
//

#import "TASStrikethroughColorParser.h"
#import "TASStrikethroughColorTag.h"
#import "TASColorManager.h"

@implementation TASStrikethroughColorParser

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASStrikethroughColorTag *tag = [[TASStrikethroughColorTag alloc] init];
    return [[TASColorManager manager] parseResultForArgument:argument tag:tag openTag:openTag];
}

@end
