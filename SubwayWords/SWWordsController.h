//
//  SWWordsController.h
//  SubwayWords
//
//  Created by nanfang on 6/22/13.
//  Copyright (c) 2013 LVTUXIONGDI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWCell.h"
#import "SWCourse.h"

@interface SWWordsController : UITableViewController <CellSlideDelegate, UIActionSheetDelegate>
@property (readonly, strong, nonatomic) SWCourse * course;
- (id)initWithCourse:(SWCourse *)course;
@end
