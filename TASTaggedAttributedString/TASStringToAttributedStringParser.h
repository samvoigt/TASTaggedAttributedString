//
//  TASStringToAttributedStringParser.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TASStringToAttributedStringParser : NSObject

- (NSAttributedString *)parseTaggedString:(NSString *)string parameters:(NSArray *)parameters;

@end
