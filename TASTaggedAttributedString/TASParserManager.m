//
//  TASParserManager.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASParserManager.h"
#import "TASUnderlineParser.h"
#import "TASStrikethroughParser.h"
#import "TASStrikethroughColorParser.h"
#import "TASParagraphParser.h"
#import "TASForegroundColorParser.h"
#import "TASBackgroundColorParser.h"
#import "TASFontParser.h"

@implementation TASParserManager

static TASParserManager *parserManager;

+ (instancetype)manager
{
    if (!parserManager)
    {
        parserManager = [[TASParserManager alloc] init];
        if (parserManager)
        {
            parserManager.openingTagParsersWitharguments = [TASParserManager formattedargumentParsers:@{kTASFontFamilyKey : [TASFontParser parserClassName],
                                                                                                    kTASFontFaceKey : [TASFontParser parserClassName],
                                                                                                    kTASFontSizeKey : [TASFontParser parserClassName],
                                                                                                    kTASParagraphAlignmentKey : [TASParagraphParser parserClassName],
                                                                                                    kTASForegroundColorKey1 : [TASForegroundColorParser parserClassName],
                                                                                                    kTASForegroundColorKey2 : [TASForegroundColorParser parserClassName],
                                                                                                    kTASBackgroundColorKey : [TASBackgroundColorParser parserClassName],
                                                                                                        kTASStrikethroughColorKey : [TASStrikethroughColorParser parserClassName]}];
            
            parserManager.openingTagParsersWithoutarguments = @{kTASFontBoldKey : [TASFontParser parserClassName],
                                                                  kTASFontItalicKey : [TASFontParser parserClassName],
                                                                  kTASTextUnderlineKey : [TASUnderlineParser parserClassName],
                                                                kTASTextStrikethroughKey : [TASStrikethroughParser parserClassName]};
            
            parserManager.closingTagParsers = @{kTASFontBoldKey : [TASFontParser parserClassName],
                                                  kTASFontItalicKey : [TASFontParser parserClassName],
                                                  kTASFontFamilyKey : [TASFontParser parserClassName],
                                                  kTASFontFaceKey : [TASFontParser parserClassName],
                                                  kTASFontSizeKey : [TASFontParser parserClassName],
                                                  kTASParagraphAlignmentKey : [TASParagraphParser parserClassName],
                                                  kTASBackgroundColorKey : [TASBackgroundColorParser parserClassName],
                                                  kTASForegroundColorKey1 : [TASForegroundColorParser parserClassName],
                                                  kTASForegroundColorKey2 : [TASForegroundColorParser parserClassName],
                                                  kTASTextUnderlineKey : [TASUnderlineParser parserClassName],
                                                  kTASTextStrikethroughKey : [TASStrikethroughParser parserClassName],
                                                  kTASStrikethroughColorKey : [TASStrikethroughColorParser parserClassName]};
        }
    }
    return parserManager;
}

+ (NSDictionary *)formattedargumentParsers:(NSDictionary *)parsers
{
    NSMutableDictionary *formattedParsers = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in parsers)
    {
        [formattedParsers setObject:parsers[key] forKey:[key stringByAppendingString:@"="]];
    }
    
    return formattedParsers;
}

- (NSDictionary *)allOpeningParsers
{
    NSMutableDictionary *allParsers = [[NSMutableDictionary alloc] initWithDictionary:self.openingTagParsersWitharguments];
    [allParsers setValuesForKeysWithDictionary:self.openingTagParsersWithoutarguments];
    return allParsers;
}

@end
