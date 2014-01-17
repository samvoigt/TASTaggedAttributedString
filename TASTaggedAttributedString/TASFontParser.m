//
//  TASFontParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASFontParser.h"
#import "TASFontManager.h"
#import "TASFontTag.h"

@implementation TASFontParser

+ (TASParseResult *)parseOpeningCommand:(NSString *)command argument:(NSString *)argument openTag:(TASTag *)openTag
{
    if ([command isEqualToString:kTASFontFamilyKey])
    {
        return [TASFontParser parseFamilyargument:argument openTag:openTag];
    }
    else if ([command isEqualToString:kTASFontFaceKey])
    {
        if ([argument rangeOfString:@"@"].location == 0)
            return [TASFontParser parseFaceFromParametersWithargument:argument openTag:openTag];
        else
            return [TASFontParser parseFaceargument:argument openTag:openTag];
    }
    else if ([command isEqualToString:kTASFontBoldKey] && ![(TASFontTag *)openTag face])
    {
        return [TASFontParser boldParseResultWithOpenTag:openTag];
    }
    else if ([command isEqualToString:kTASFontItalicKey] && ![(TASFontTag *)openTag face])
    {
        return [TASFontParser italicParseResultWithOpenTag:openTag];
    }
    else if ([command isEqualToString:kTASFontSizeKey])
    {
        return [TASFontParser parseSizeargument:argument openTag:openTag];
    }
    
    return nil;
}

+ (TASParseResult *)parseFaceargument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASFontTag  *openFontTag = (TASFontTag *)openTag;
    
    if (openFontTag && [[openFontTag.face fontName] isEqualToString:argument]) {
        return nil;
    }
    
    TASParseResult *parseResult = [TASParseResult parseResultWithClosingTag:openTag];
    TASFontTag *newFontTag = [[TASFontTag alloc] init];
    CGFloat size = parseResult.tag ? [(TASFontTag *)parseResult.tag size] : [TASFontManager defaultSize];
    newFontTag.face = [UIFont fontWithName:argument size:size];
    parseResult.tag = newFontTag;
    
    return  parseResult;
}

+ (TASParseResult *)parseFaceFromParametersWithargument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASFontTag  *openFontTag = (TASFontTag *)openTag;
    
    UIFont *newFont = [[TASFontManager manager] fontForIndex:[[argument substringFromIndex:1] integerValue]];
    
    if ((openFontTag && [openFontTag.face isEqual:newFont]) || !newFont)
    {
        return nil;
    }
    
    TASParseResult *parseResult = [TASParseResult parseResultWithClosingTag:openFontTag];
    TASFontTag *newFontTag = [[TASFontTag alloc] init];
    newFontTag.face = newFont;
    parseResult.tag = newFontTag;
    
    return parseResult;
}

+ (TASParseResult *)parseFamilyargument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASFontTag  *openFontTag = (TASFontTag *)openTag;
    if (openFontTag && [openFontTag.family isEqualToString:argument]) {
        return nil;
    }
    
    TASParseResult *parseResult = [TASFontParser familyParseResultWithWithOpenTag:openFontTag];
    [(TASFontTag *)parseResult.tag setFamily:argument];
    
    return  parseResult;
}

+ (TASParseResult *)boldParseResultWithOpenTag:(TASTag *)openTag
{
    if (openTag && [(TASFontTag *)openTag bold])
    {
        return nil;
    }
    
    TASParseResult *parseResult = [TASFontParser familyParseResultWithWithOpenTag:(TASFontTag *)openTag];
    [(TASFontTag *)parseResult.tag setBold:YES];
    
    return  parseResult;
}

+ (TASParseResult *)italicParseResultWithOpenTag:(TASTag *)openTag
{
    if (openTag && [(TASFontTag *)openTag italic])
    {
        return nil;
    }
    
    TASParseResult *parseResult = [TASFontParser familyParseResultWithWithOpenTag:(TASFontTag *)openTag];
    [(TASFontTag *)parseResult.tag setItalic:YES];
    
    return  parseResult;
}

+ (TASParseResult *)parseSizeargument:(NSString *)argument openTag:(TASTag *)openTag
{
    TASFontTag  *openFontTag = (TASFontTag *)openTag;
    CGFloat fontSize = [argument floatValue];
    
    if (openFontTag && [openFontTag size] == fontSize)
    {
        return nil;
    }
    
    TASParseResult *parseResult;
    
    if (openFontTag && openFontTag.face)
    {
        parseResult = [TASFontParser fontParseResultWithOpenTag:openFontTag];
        [(TASFontTag *)parseResult.tag setFace:[[(TASFontTag *)parseResult.tag face] fontWithSize:fontSize]];
    }
    else
    {
        parseResult = [TASFontParser familyParseResultWithWithOpenTag:(TASFontTag *)openTag];
        [(TASFontTag *)parseResult.tag setSize:fontSize];
    }
    return  parseResult;
}

+ (TASParseResult *)familyParseResultWithWithOpenTag:(TASFontTag *)openTag
{
    TASParseResult *parseResult = [TASFontParser fontParseResultWithOpenTag:(TASFontTag *)openTag];
    if (![(TASFontTag *)parseResult.tag family])
        [(TASFontTag *)parseResult.tag setFamily:[TASFontManager defaultFamily]];
    
    return parseResult;
}

+ (TASParseResult *)fontParseResultWithOpenTag:(TASFontTag *)openTag
{
    TASParseResult *parseResult = [TASParseResult parseResultWithClosingTag:openTag];
    TASFontTag *newFontTag;
    
    if (openTag)
    {
        newFontTag = [openTag copy];
    }
    else
    {
        newFontTag = [[TASFontTag alloc] init];
        newFontTag.size =  [TASFontManager defaultSize];
    }
    parseResult.tag = newFontTag;
    return parseResult;
}

+ (TASParseResult *)parseClosingCommand:(NSString *)command openTag:(TASTag *)openTag
{
    TASFontTag *openFontTag = (TASFontTag *)openTag;
    TASParseResult *parseResult = nil;
    
    if ([command isEqualToString:kTASFontFaceKey] || [command isEqualToString:kTASFontFamilyKey])
    {
        parseResult = [[TASParseResult alloc] init];
        parseResult.closingTag = openFontTag;
    }
    else if ([command isEqualToString:kTASFontBoldKey])
    {
        if (openFontTag.bold)
        {
            parseResult = [TASFontParser fontParseResultWithOpenTag:openFontTag];
            [(TASFontTag *)parseResult.tag setBold:NO];
        }
    }
    else if ([command isEqualToString:kTASFontItalicKey])
    {
        if (openFontTag.italic)
        {
            parseResult = [TASFontParser fontParseResultWithOpenTag:openFontTag];
            [(TASFontTag *)parseResult.tag setItalic:NO];
        }
    }
    return parseResult;
}

+ (BOOL)parsesClosingTag
{
    return YES;
}

@end
