#import <UIKit/UIKit.h>
#import "SWWord.h"

@class SWCell;

typedef enum {
    CellSlideDirectionRight = 0,
	CellSlideDirectionLeft,
	CellSlideDirectionBoth,
	CellSlideDirectionNone,
} CellSlideDirection;

@protocol CellSlideDelegate <NSObject>

@optional
- (void)cellDidHide:(SWCell *)cell;
- (void)cellDidUnhide:(SWCell *)cell;
@end

@interface SWCell : UITableViewCell

// model
@property(nonatomic,strong) SWWord * word;

// slide
@property BOOL hide;
@property (weak) id <CellSlideDelegate> delegate;
@property (nonatomic, assign) CellSlideDirection direction;
@property BOOL shouldBounce;

//-(void)showSweep;
@end
