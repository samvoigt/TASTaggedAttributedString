//
//  TASFontManager.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASFontManager.h"

@implementation TASFontManager

static TASFontManager *fontManager = nil;

+ (TASFontManager *)manager
{
    if (!fontManager)
    {
        fontManager = [[TASFontManager alloc] init];
    }
    return fontManager;
}


+ (NSString *)defaultFamily
{
    return @"HelveticaNeue";
}

+ (CGFloat)defaultSize
{
    return 12.0;
}

- (void)reset
{
    if (self.fonts)
        [self.fonts removeAllObjects];
}

- (void)addFont:(UIFont *)font
{
    if (!self.fonts)
        self.fonts = [[NSMutableArray alloc] init];
    
    [self.fonts addObject:font];
}

- (UIFont *)fontForIndex:(NSInteger)index
{
    index--;
    if (index >= self.fonts.count || index < 0) {
        return nil;
    }
    return self.fonts[index];
}

@end
