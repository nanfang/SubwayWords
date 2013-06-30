//
//  SWMainController.m
//  SubwayWords
//
//  Created by nanfang on 6/22/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import "SWMainController.h"
#import "SESpringBoard.h"
#import "SWWordsController.h"
#import "SWCourse.h"
@interface SWMainController ()

@end

@implementation SWMainController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // TODO load coures from DB
    NSMutableArray *items = [NSMutableArray array];
    NSArray* courses = @[[[SWCourse alloc]initWithName:@"雅思词汇" image:@"ielts" table:@"ielts"]];

    for (SWCourse* course in courses){
        SWWordsController *ctl = [[SWWordsController alloc] initWithCourse:course];
        [items addObject:[SEMenuItem initWithTitle:course.name frame:CGRectMake(0, 0, 100, 100) imageName:course.image viewController:ctl removable:NO]];
    }

    
    SESpringBoard *board = [SESpringBoard initWithTitle:@"地铁背单词" items:items launcherImage:[UIImage imageNamed:@"navbtn_home.png"]];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:board];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
