//
//  SWWordsController.m
//  SubwayWords
//
//  Created by nanfang on 6/22/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import "SWWordsController.h"
#import "SWCell.h"

@interface SWWordsController ()

@end

@implementation SWWordsController
@synthesize course=_course;

- (id)initWithCourse:(SWCourse *)course
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _course=course;
        self.title = course.name;
    }
    return self;
}


- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *levelLauncher = [[UIBarButtonItem alloc] initWithTitle:@"级别" style:UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector (showLevelSheet)];
    self.navigationItem.rightBarButtonItems = @[levelLauncher];
}



- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationItem.rightBarButtonItem.title = [self.course currentUserLevel].description;
}


- (void)showLevelSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择级别"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:nil];
    for(SWLevel * level in [self.course allLevels]){
        [actionSheet addButtonWithTitle:level.description];
    }
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex > 0){
        [self.course switchUserLevel:[self.course allLevels][buttonIndex-1]];
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem.title = [self.course currentUserLevel].description;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.course currentLevelWords].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SWCell";
    SWCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SWCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 18];
        [cell.textLabel setShadowOffset:CGSizeMake(0.0, -0.6)];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
    }
    
    cell.word = [self.course currentLevelWords][indexPath.row];
    cell.hide = NO;
    cell.direction = CellSlideDirectionBoth;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sliced_bg_green"]];
    cell.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"noise"]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

@end
