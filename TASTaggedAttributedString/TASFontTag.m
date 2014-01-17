//
//  TASFontTag.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASFontTag.h"
#import "TASFontParser.h"

@implementation TASFontTag

- (TASAttribute *)attributeForTag
{
    if (self.family)
    {
        NSString *subFontName;
        if (self.bold && self.italic) {
            subFontName = @"BoldItalic";
        }
        else if (self.bold)
        {
            subFontName = @"Bold";
        }
        else if (self.italic)
        {
            subFontName = @"Italic";
        }
        
        subFontName = subFontName ? [NSString stringWithFormat:@"%@-%@", self.family, subFontName] : self.family;
        
        self.face = [UIFont fontWithName:subFontName size:self.size];
        if (!self.face) // Catch for invalid sub font due to not having a bold/italic version
        {
            self.face = [UIFont fontWithName:self.family size:self.size];
        }
    }
    
    if (!self.face)
        return nil;
    
    return [TASAttribute TASAttributeWithKey:NSFontAttributeName
                                       value:self.face
                                       range:[self rangeForTag]];
}

- (NSString *)tagParsingClassName
{
    return NSStringFromClass([TASFontParser class]);
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    TASFontTag *copy = [[[self class] alloc] init];
    
    copy.bold = self.bold;
    copy.italic = self.italic;
    copy.size = self.size;
    copy.family = [self.family copy];
    copy.face = [self.face copy];
    
    return copy;
}

@end
