//
//  TASParseResult.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TASTag;

@interface TASParseResult : NSObject

+ (TASParseResult *)parseResultWithClosingTag:(TASTag *)closingTag;

@property (nonatomic, strong) TASTag *closingTag;
@property (nonatomic, strong) TASTag *tag;

@end
