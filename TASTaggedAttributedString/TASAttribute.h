//
//  TASAttribute.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TASAttribute : NSObject

@property (nonatomic, strong) NSString *attributeKey;
@property (nonatomic, strong) id attributeValue;
@property (nonatomic) NSRange attributeRange;

+ (TASAttribute *)TASAttributeWithKey:(NSString *)key value:(id)value range:(NSRange)range;

@end