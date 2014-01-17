//
//  TASFontManager.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TASFontManager : NSObject

+ (TASFontManager *)manager;
+ (NSString *)defaultFamily;
+ (CGFloat)defaultSize;

@property (nonatomic, strong) NSMutableArray *fonts;

- (void)reset;
- (void)addFont:(UIFont *)font;
- (UIFont *)fontForIndex:(NSInteger)index;

@end
