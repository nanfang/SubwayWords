//
//  SWWord.m
//  SubwayWords
//
//  Created by nanfang on 6/22/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SWWord.h"

@implementation SWWord
@synthesize word=_word, explain=_explain, soundmark=_soundmark, level=_level;
- (id)initWithWord:(NSString*)word explain:(NSString*)explain soundmark:(NSString*)soundmark level:(int)level
{
    self = [super init];
    if (self) {
        self.word = word;
        self.explain = explain;
        self.soundmark = soundmark;
        self.level = level;
    }
    return self;
}

@end
