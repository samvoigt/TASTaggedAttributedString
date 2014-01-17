//
//  TASColorManager.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASColorManager.h"

@interface TASColorManager()

@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation TASColorManager

static TASColorManager *colorManager = nil;

+ (TASColorManager *)manager
{
    if (!colorManager)
    {
        colorManager = [[TASColorManager alloc] init];
        colorManager.colors = [[NSMutableArray alloc] init];
    }
    return colorManager;
}


- (void)reset
{
    [self.colors removeAllObjects];
}

- (void)addColor:(UIColor *)color
{
    [self.colors addObject:color];
}

- (UIColor *)colorForIndex:(NSInteger)index
{
    index--;
    if (index >= self.colors.count || index < 0) {
        return nil;
    }
    return self.colors[index];
}

- (TASParseResult *)parseResultForArgument:(NSString *)argument tag:(TASColorTag *)tag openTag:(TASTag *)openTag
{
    argument = [argument lowercaseString];
    if ([argument rangeOfString:@"@"].location == 0)
    {
        [tag setColor:[[TASColorManager manager] colorForIndex:[[argument substringFromIndex:1] integerValue]]];
    }
    else if ([argument isEqualToString:@"black"]){
        
    } else if ([argument isEqualToString:@"darkgray"] ||
               [argument isEqualToString:@"darkgrey"]){
        [tag setColor:[UIColor darkGrayColor]];
    } else if ([argument isEqualToString:@"lightgray"] ||
               [argument isEqualToString:@"lightgrey"]){
        [tag setColor:[UIColor lightGrayColor]];
    } else if ([argument isEqualToString:@"white"]){
        [tag setColor:[UIColor whiteColor]];
    } else if ([argument isEqualToString:@"red"]){
        [tag setColor:[UIColor redColor]];
    } else if ([argument isEqualToString:@"green"]){
        [tag setColor:[UIColor greenColor]];
    } else if ([argument isEqualToString:@"blue"]){
        [tag setColor:[UIColor blueColor]];
    } else if ([argument isEqualToString:@"cyan"]){
        [tag setColor:[UIColor cyanColor]];
    } else if ([argument isEqualToString:@"yellow"]){
        [tag setColor:[UIColor yellowColor]];
    } else if ([argument isEqualToString:@"magenta"]){
        [tag setColor:[UIColor magentaColor]];
    } else if ([argument isEqualToString:@"orange"]){
        [tag setColor:[UIColor orangeColor]];
    } else if ([argument isEqualToString:@"purple"]){
        [tag setColor:[UIColor purpleColor]];
    } else if ([argument isEqualToString:@"brown"]){
        [tag setColor:[UIColor brownColor]];
    } else if ([argument isEqualToString:@"clear"]){
        [tag setColor:[UIColor clearColor]];
    } else if ([argument isEqualToString:@"lighttext"]){
        [tag setColor:[UIColor lightTextColor]];
    } else if ([argument isEqualToString:@"darktext"]){
        [tag setColor:[UIColor darkTextColor]];
    } else if ([argument isEqualToString:@"grouptableviewbackground"]){
        [tag setColor:[UIColor groupTableViewBackgroundColor]];
    } else if ([argument rangeOfString:@"#" options:NSCaseInsensitiveSearch].location == 0){
        argument = [argument substringFromIndex:1]; // ignore the #
        
        if ([argument length] != 6)
        {
            [tag setColor:[UIColor blackColor]];
        }
        else
        {
            NSScanner *scanner = [NSScanner scannerWithString:argument];
            unsigned int hex;
            [scanner scanHexInt:&hex];
            [tag setColor:[UIColor colorWithRed:((hex>>16)&0xFF)/255.0 green:((hex>>8)&0xFF)/255.0 blue:(hex&0xFF)/255.0 alpha:1.0]];
        }
    } else {
        [tag setColor:[UIColor blackColor]];
    }
    
    TASParseResult *parseResult = [[TASParseResult alloc] init];
    
    parseResult.tag = tag;
    parseResult.closingTag = openTag;
    return parseResult;
}

@end
