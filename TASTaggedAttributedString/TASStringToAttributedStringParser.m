//
//  TASStringToAttributedStringParser.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASStringToAttributedStringParser.h"
#import "TASParserManager.h"
#import "TASColorManager.h"
#import "TASFontManager.h"
#import "TASParser.h"
#import "TASParseResult.h"

@interface TASStringToAttributedStringParser()

@property (nonatomic, strong) NSString *inputString;
@property (nonatomic, strong) NSString *outputString;

@property (nonatomic, strong) NSMutableDictionary *openTags;

@property (nonatomic, strong) NSMutableArray *attributeList;

@property (nonatomic) NSInteger plainStartingIndex;
@property (nonatomic) NSInteger plainCurrentIndex;
@property (nonatomic) NSInteger attributedCurrentIndex;

@property (nonatomic, readonly) BOOL hasMoreInput;

@end

@implementation TASStringToAttributedStringParser


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self initializeVariables];
    }
    return self;
}

- (void)initializeVariables
{
    self.inputString =
    self.outputString = @"";
    
    self.plainStartingIndex =
    self.plainCurrentIndex =
    
    self.attributedCurrentIndex = 0;
    
    self.attributeList = [[NSMutableArray alloc] init];
    self.openTags = [[NSMutableDictionary alloc] init];
}

- (NSAttributedString *)parseTaggedString:(NSString *)string parameters:(NSArray *)parameters
{
    if (string)
    {
        if (parameters)
        {
            [self loadParameters:parameters];
        }
        [self generateAttributeTagsForString:string];
        return [self generateAttributedString];
    }
    else
    {
        return nil;
    }
}

- (void)loadParameters:(NSArray *)parameters
{
    TASFontManager *fontManager = [TASFontManager manager];
    TASColorManager *colorManager = [TASColorManager manager];
    [fontManager reset];
    [colorManager reset];
    
    for (id parameter in parameters)
    {
        if ([parameter isKindOfClass:[UIFont class]])
        {
            [fontManager addFont:(UIFont *)parameter];
        }
        else if ([parameter isKindOfClass:[UIColor class]])
        {
            [colorManager addColor:(UIColor *)parameter];
        }
    }
}

- (void)closeOpenTags
{
    NSArray *openTagKeys = [self.openTags allKeys]; // We can't mutate the dictionary while enumerating it, hence we do this...
    for (NSString *key in openTagKeys)
    {
        [self closeTagForKey:key];
    }
}

- (void)generateAttributeTagsForString:(NSString *)string
{
    self.inputString = string;
    while (self.hasMoreInput)
    {
        if ([self.inputString characterAtIndex:self.plainCurrentIndex] == '<' &&
            (self.plainCurrentIndex == 0 || [self.inputString characterAtIndex:self.plainCurrentIndex -1] != '\\')) // Check to make sure we haven't escaped out of the opening bracket
        {
            [self addTextToOutputString];
            
            self.plainCurrentIndex++; // Move past the opening <
            if (self.hasMoreInput && [self.inputString characterAtIndex:self.plainCurrentIndex] == '/')
            {
                [self parseClosingTag];
            }
            else
            {
                [self parseOpeningTag];
            }
        }
        else
        {
            self.attributedCurrentIndex++;
        }
        self.plainCurrentIndex++;
    }
    [self addTextToOutputString];
    [self closeOpenTags];
}

- (void)addTextToOutputString
{
    NSRange outputRange = {self.plainStartingIndex, self.plainCurrentIndex - self.plainStartingIndex};
    if (outputRange.length > 0)
    {
        self.outputString = [self.outputString stringByAppendingString:[self.inputString substringWithRange:outputRange]];
    }
    self.plainStartingIndex = self.plainCurrentIndex;
}

- (void)parseOpeningTag
{
    while (self.hasMoreInput && [self.inputString characterAtIndex:self.plainCurrentIndex] != '>')
    {
        while ([self.inputString characterAtIndex:self.plainCurrentIndex] == ' ')
            self.plainCurrentIndex++;
        
        for (NSString *commandName in [[TASParserManager manager].allOpeningParsers allKeys])
        {
            NSRange commandRange = [[self.inputString substringFromIndex:self.plainCurrentIndex] rangeOfString:commandName];
            if (commandRange.location == 0)
            {
                NSString *command = [self isCommandWithargument:commandName] ? [self nakedCommandForCommandName:commandName] : commandName;
                NSString *argument = [self isCommandWithargument:commandName] ?  [self argumentWithCommandRange:commandRange] : nil;
                
                TASParseResult *parseResult = [NSClassFromString([TASParserManager manager].allOpeningParsers[commandName])
                                               parseOpeningCommand:(NSString *)command
                                               argument:(NSString *)argument
                                               openTag:self.openTags[[TASParserManager manager].allOpeningParsers[commandName]]];
                
                [self processParseResult:parseResult];
                break;
            }
        }
        self.plainCurrentIndex += [self indexOfNextTagInInputString];
    }
    self.plainStartingIndex = self.plainCurrentIndex + 1;
}

- (void)parseClosingTag
{
    self.plainCurrentIndex++; // Move past the / at the beginning of a closing tag
    
    while (self.hasMoreInput && [self.inputString characterAtIndex:self.plainCurrentIndex] != '>')
    {
        for (NSString *commandName in [[TASParserManager manager].closingTagParsers allKeys])
        {
            if ([[self.inputString substringFromIndex:self.plainCurrentIndex] rangeOfString:commandName].location == 0)
            {
                if ([NSClassFromString([TASParserManager manager].closingTagParsers[commandName]) parsesClosingTag])
                {
                    TASParseResult *parseResult = [NSClassFromString([TASParserManager manager].closingTagParsers[commandName])
                                                   parseClosingCommand:commandName
                                                   openTag:self.openTags[[TASParserManager manager].closingTagParsers[commandName]]];
                    
                    [self processParseResult:parseResult];
                }
                else
                {
                    [self closeTagForKey:[TASParserManager manager].closingTagParsers[commandName]];
                }
                break;
            }
        }
        self.plainCurrentIndex += [self indexOfNextTagInInputString];
    }
    self.plainStartingIndex = self.plainCurrentIndex + 1;
}

- (BOOL)isCommandWithargument:(NSString *)command
{
    return [command rangeOfString:@"="].location != NSNotFound;
}

- (NSString *)nakedCommandForCommandName:(NSString *)command
{
    return [command substringToIndex:[command rangeOfString:@"="].location];
}

- (NSString *)argumentWithCommandRange:(NSRange)range
{
    return  [[self.inputString substringWithRange:NSMakeRange(self.plainCurrentIndex + range.location + range.length , [self indexOfNextTagInInputString] - range.length)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)indexOfNextTagInInputString
{
    NSInteger nextComma = [[self.inputString substringFromIndex:self.plainCurrentIndex] rangeOfString:@","].location;
    NSInteger nextClosingBrace = [[self.inputString substringFromIndex:self.plainCurrentIndex] rangeOfString:@">"].location;
    return MAX(1, ( MIN(nextComma, nextClosingBrace)));
}

- (void)processParseResult:(TASParseResult *)parseResult
{
    if (parseResult)
    {
        if (parseResult.closingTag)
        {
            parseResult.closingTag.endingLocation = self.attributedCurrentIndex;
            TASAttribute *attribute = [parseResult.closingTag attributeForTag];
            if (attribute)
                [self.attributeList addObject:attribute];
        }
        if (parseResult.tag)
        {
            parseResult.tag.startingLocation = self.attributedCurrentIndex;
            [self.openTags setObject:parseResult.tag forKey:[parseResult.tag tagParsingClassName]];
        }
    }
}

- (BOOL)hasMoreInput
{
    return self.plainCurrentIndex < self.inputString.length;
}

- (void)closeTagForKey:(NSString *)key
{
    TASTag *tag = self.openTags[key];
    if (tag)
    {
        tag.endingLocation = self.attributedCurrentIndex;
        TASAttribute *attribute = [tag attributeForTag];
        if (attribute)
            [self.attributeList addObject:attribute];
        [self.openTags removeObjectForKey:key];
    }
}

- (NSAttributedString *)generateAttributedString
{
    NSMutableAttributedString *attributedOutput = [[NSMutableAttributedString alloc] initWithString:self.outputString];
    
    for (TASAttribute *attribute in self.attributeList)
    {
        [attributedOutput addAttribute:attribute.attributeKey value:attribute.attributeValue range:attribute.attributeRange];
    }
    return attributedOutput;
}

@end
