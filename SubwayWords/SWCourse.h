//
//  SWCourse.h
//  SubwayWords
//
//  Created by nanfang on 6/30/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWLevel.h"

@interface SWCourse : NSObject
@property(readonly,strong,nonatomic) NSString * name;
@property(readonly,strong,nonatomic) NSString * image;

- (id)initWithName:(NSString*)name image:(NSString*)image table:(NSString*)table;
- (SWLevel*)currentUserLevel;
- (void)switchUserLevel:(SWLevel*)level;

- (NSArray*)allLevels;
- (NSArray*)currentLevelWords;
- (void)turnUpWord:(NSString*)word;
- (void)turnDownWord:(NSString*)word;

@end
