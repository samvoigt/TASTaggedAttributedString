//
//  TASFontTag.h
//  Tagged Attributed String
//
//  Created by Samuel Voigt on 12/23/13.
//  Copyright (c) 2013 Sam Voigt. All rights reserved.
//

#import "TASTag.h"

@interface TASFontTag : TASTag

@property (nonatomic, strong) NSString *family;
@property (nonatomic, strong) UIFont *face;
@property (nonatomic) BOOL bold;
@property (nonatomic) BOOL italic;
@property (nonatomic) CGFloat size;

@end
