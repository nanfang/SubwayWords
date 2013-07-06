//
//  SWLevel.m
//  SubwayWords
//
//  Created by nanfang on 6/30/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import "SWLevel.h"

@implementation SWLevel
@synthesize level=_level;

- (id)initWithLevel:(int)level
{
    self = [super init];
    if (self) {
        _level = level;
    }
    return self;
}


- (NSString*)description
{
    return [NSString stringWithFormat:@"第%@级", [NSNumber numberWithInt:_level]];
}


+ (SWLevel*)levelOf:(int)level{
    return [[SWLevel alloc]initWithLevel:level];
}

@end
