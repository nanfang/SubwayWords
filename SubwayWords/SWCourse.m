//
//  SWCourse.m
//  SubwayWords
//
//  Created by nanfang on 6/30/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import "SWCourse.h"
#import "SWWord.h"

@interface SWCourse(){
    NSString* _table;
}

@end

@implementation SWCourse


@synthesize name=_name;
@synthesize image=_image;

- (id)initWithName:(NSString*)name image:(NSString*)image table:(NSString*)table
{
    self = [super init];
    if (self) {
        _name=name;
        _table=table;
        _image=image;
    }
    return self;
}

- (NSArray*)currentLevelWords
{
    // TODO load words from db
    SWWord* word = [[SWWord alloc]initWithWord:@"abandon" explain:@"vt.放弃, 遗弃 n.放任, 狂热 vt.放弃, 遗弃 n.放任, 狂热 vt.放弃, 遗弃 n.放任, 狂热" soundmark:@"" level:1];
    return @[word, word, word, word, word, word, word, word, word, word];
}

- (NSArray*)allLevels
{
    // TODO load existed levels from db
    return @[[SWLevel levelOf:0], [SWLevel levelOf:1], [SWLevel levelOf:2], [SWLevel levelOf:3]];
}

- (SWLevel*)currentUserLevel
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int level = [userDefaults integerForKey:[self userLevelKey]];
    return [SWLevel levelOf:level];
}

- (void)switchUserLevel:(SWLevel*)level
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:level.level forKey:[self userLevelKey]];
}

- (void)turnUpWord:(NSString*)word
{
    // TODO impl
}

- (void)turnDownWord:(NSString*)word
{
    // TODO impl
}

- (NSString*) userLevelKey
{
    return [NSString stringWithFormat:@"user_level:%@", _name];
}

@end
