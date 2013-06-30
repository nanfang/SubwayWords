//
//  SWWord.h
//  SubwayWords
//
//  Created by nanfang on 6/22/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWWord : NSObject
@property(strong, nonatomic) NSString * word;
@property(strong, nonatomic) NSString * explain;
@property(strong, nonatomic) NSString * soundmark;
@property(nonatomic) int level;
- (id)initWithWord:(NSString*)word explain:(NSString*)explain soundmark:(NSString*)soundmark level:(int)level;
@end
