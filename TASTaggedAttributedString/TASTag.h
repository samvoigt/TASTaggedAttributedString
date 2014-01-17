//
//  TASTag.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TASAttribute.h"

@interface TASTag : NSObject

@property (nonatomic) NSInteger startingLocation;
@property (nonatomic) NSInteger endingLocation;

- (TASAttribute *)attributeForTag;
- (NSString *)tagParsingClassName;
- (NSRange)rangeForTag;

@end

