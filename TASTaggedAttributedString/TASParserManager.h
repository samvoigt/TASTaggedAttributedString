//
//  TASParserManager.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TASParserManagerConstants.h"

@interface TASParserManager : NSObject

+ (instancetype)manager;

@property (nonatomic, strong) NSDictionary *openingTagParsersWitharguments;
@property (nonatomic, strong) NSDictionary *openingTagParsersWithoutarguments;
@property (nonatomic, readonly) NSDictionary *allOpeningParsers;

@property (nonatomic, strong) NSDictionary *closingTagParsers;

@end
