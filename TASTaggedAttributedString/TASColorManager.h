//
//  TASColorManager.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TASParseResult.h"
#import "TASColorTag.h"

@interface TASColorManager : NSObject

+ (TASColorManager *)manager;
- (void)reset;
- (void)addColor:(UIColor *)color;

- (TASParseResult *)parseResultForArgument:(NSString *)argument tag:(TASColorTag *)tag openTag:(TASTag *)openTag;


@end
