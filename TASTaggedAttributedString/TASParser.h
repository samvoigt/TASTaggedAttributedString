//
//  TASParser.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TASParserManager.h"
#import "TASParseResult.h"
#import "TASTag.h"

@interface TASParser : NSObject

+ (NSString *)parserClassName;
+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag;
+ (TASParseResult *)parseClosingCommand:(NSString *)command openTag:(TASTag *)openTag;
+ (BOOL)parsesClosingTag;

@end
