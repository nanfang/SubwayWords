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


- (id)initWithTitle:(NSString *)title
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = title;
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

    UIBarButtonItem *levelLauncher = [[UIBarButtonItem alloc] initWithTitle:@"一级" style:UIBarButtonItemStylePlain
                                                                     target: self
                                                                     action: @selector (showLevelSheet)];
    self.navigationItem.rightBarButtonItems = @[levelLauncher];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)showLevelSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"选择级别"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"一级", @"二级",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // TODO: Return the number of the words
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SWCell";
    SWCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[SWCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont boldSystemFontOfSize: 18];
        [cell.textLabel setShadowOffset:CGSizeMake(0.0, -0.6)];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.delegate = self;
    }
    // TODO load word from db
    SWWord * word = [[SWWord alloc]initWithWord:@"abandon" explain:@"vt.放弃, 遗弃 n.放任, 狂热 vt.放弃, 遗弃 n.放任, 狂热 vt.放弃, 遗弃 n.放任, 狂热" soundmark:@"" level:1];

//    cell.textLabel.text = word.word;
    cell.word = word;
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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end
