//
//  SWLevel.h
//  SubwayWords
//
//  Created by nanfang on 6/30/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWLevel : NSObject
@property(readonly, nonatomic) int level;

+ (SWLevel*)levelOf:(int)level;
- (id)initWithLevel:(int)level;

@end
