//
//  TASBackgroundColorParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 1/3/14.
//  Copyright (c) 2014 Sam Voigt. All rights reserved.
//

#import "TASBackgroundColorParser.h"
#import "TASBackgroundColorTag.h"
#import "TASColorManager.h"

@implementation TASBackgroundColorParser

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASBackgroundColorTag *tag = [[TASBackgroundColorTag alloc] init];
    return [[TASColorManager manager] parseResultForArgument:argument tag:tag openTag:openTag];
}

@end
