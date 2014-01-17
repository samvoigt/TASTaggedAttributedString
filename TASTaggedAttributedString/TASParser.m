//
//  TASParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASParser.h"

@implementation TASParser

+ (NSString *)parserClassName
{
    return NSStringFromClass([self class]);
}

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (TASParseResult *)parseClosingCommand:(NSString *)command openTag:(TASTag *)openTag
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (BOOL)parsesClosingTag
{
    return NO;
}

@end
