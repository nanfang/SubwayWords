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
@synthesize currentLevel=_currentLevel;

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
    return @[@1, @2, @3];
}

- (void)turnUpWord:(NSString*)word
{
    // TODO impl
}

- (void)turnDownWord:(NSString*)word
{
    // TODO impl
}


@end
