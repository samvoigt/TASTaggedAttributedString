//
//  TASAttribute.m
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/20/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASAttribute.h"

@implementation TASAttribute

+ (TASAttribute *)TASAttributeWithKey:(NSString *)key value:(id)value range:(NSRange)range
{
    TASAttribute *attribute = [[TASAttribute alloc] init];
    attribute.attributeKey = key;
    attribute.attributeValue = value;
    attribute.attributeRange = range;
    return attribute;
}

@end
