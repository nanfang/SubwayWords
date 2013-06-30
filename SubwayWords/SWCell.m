#import "SWCell.h"
#import <QuartzCore/QuartzCore.h>

@interface SWCell ()

@property (nonatomic, retain) UIPanGestureRecognizer   *_panGesture;
@property (nonatomic, assign) CGFloat _initialTouchPositionX;
@property (nonatomic, assign) CGFloat _initialHorizontalCenter;
@property (nonatomic, assign) CellSlideDirection _lastDirection;
@property (nonatomic, assign) CellSlideDirection _currentDirection;


@property (nonatomic, strong) UILabel *_indicatorLabel;
@property (nonatomic, strong) UIButton *_upButton;
@property (nonatomic, strong) UIButton *_downButton;

- (void)_slideInContentViewFromDirection:(CellSlideDirection)direction offsetMultiplier:(CGFloat)multiplier;
- (void)_slideOutContentViewInDirection:(CellSlideDirection)direction;

- (void)_pan:(UIPanGestureRecognizer *)panGesture;


- (CGFloat)_originalCenter;
- (CGFloat)_bounceMultiplier;

- (BOOL)_shouldDragLeft;
- (BOOL)_shouldDragRight;

@end

@implementation SWCell

#pragma mark - Private Properties

@synthesize _panGesture;
@synthesize _initialTouchPositionX;
@synthesize _initialHorizontalCenter;
@synthesize _lastDirection;
@synthesize _currentDirection;

@synthesize _indicatorLabel;

#pragma mark - Public Properties
@synthesize word=_word;
@synthesize hide = _hide;
@synthesize direction    = _direction;
@synthesize delegate     = _delegate;
@synthesize shouldBounce = _shouldBounce;


#pragma mark - Lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.shouldBounce = YES;
		
		self._panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan:)] ;
		self._panGesture.delegate = self;
		
		[self addGestureRecognizer:self._panGesture];
		
		
		UIView *backgroundView = [[UIView alloc] initWithFrame:self.contentView.frame] ;
		self.backgroundView = backgroundView;
        
        
        // init background view
        self._indicatorLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 200, 65)];
        self._indicatorLabel.text = @"解释";
        self._indicatorLabel.textColor = [UIColor whiteColor];
        self._indicatorLabel.backgroundColor = [UIColor clearColor];

        
        self._upButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self._upButton.frame = CGRectMake(210, 25, 45, 40);
        [self._upButton setTitle:@"升级" forState:UIControlStateNormal];
        
        self._downButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self._downButton.frame = CGRectMake(265, 25, 45, 40);
        [self._downButton setTitle:@"降级" forState:UIControlStateNormal];
        
        [self.backgroundView addSubview:self._indicatorLabel];
        [self.backgroundView addSubview:self._upButton];
        [self.backgroundView addSubview:self._downButton];
    }
    return self;
}


- (void)layoutSubviews
{
	[super layoutSubviews];	    
    self.textLabel.text = self.word.word;
    self._indicatorLabel.text = self.word.explain;
    [self._indicatorLabel setNumberOfLines:0];
    [self._indicatorLabel sizeToFit];
    if(self.hide){
        [self _hideOutContentViewInDirection: CellSlideDirectionRight];
    }
}


#pragma mark - Handing Touch

#define kMinimumVelocity self.contentView.frame.size.width
#define kMinimumPan      60.0

- (void)_pan:(UIPanGestureRecognizer *)recognizer
{
	
	CGPoint translation           = [recognizer translationInView:self];
	CGPoint currentTouchPoint     = [recognizer locationInView:self];
	CGPoint velocity              = [recognizer velocityInView:self];
	
	CGFloat originalCenter        = self._originalCenter;
	CGFloat currentTouchPositionX = currentTouchPoint.x;
	CGFloat panAmount             = self._initialTouchPositionX - currentTouchPositionX;
	CGFloat newCenterPosition     = self._initialHorizontalCenter - panAmount;
	CGFloat centerX               = self.contentView.center.x;
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		
		// Set a baseline for the panning
		self._initialTouchPositionX = currentTouchPositionX;
		self._initialHorizontalCenter = self.contentView.center.x;
				
	} else if (recognizer.state == UIGestureRecognizerStateChanged) {
		
		// If the pan amount is negative, then the last direction is left, and vice versa.
		if (newCenterPosition - centerX < 0)
			self._lastDirection = CellSlideDirectionLeft;
		else
			self._lastDirection = CellSlideDirectionRight;
		
		// Don't let you drag past a certain point depending on direction
		if ((newCenterPosition < originalCenter && !self._shouldDragLeft) || (newCenterPosition > originalCenter && !self._shouldDragRight))
			newCenterPosition = originalCenter;
		
		// Let's not go waaay out of bounds
		if (newCenterPosition > self.bounds.size.width + originalCenter)
			newCenterPosition = self.bounds.size.width + originalCenter;
		
		else if (newCenterPosition < -originalCenter)
			newCenterPosition = -originalCenter;
		
		CGPoint center = self.contentView.center;
		center.x = newCenterPosition;
		
		self.contentView.layer.position = center;
		
	} else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
				
		// Swiping left, velocity is below 0.
		// Swiping right, it is above 0
		// If the velocity is above the width in points per second at any point in the pan, push it to the acceptable side
		// Otherwise, if we are 60 points in, push to the other side
		// If we are < 60 points in, bounce back
		
		CGFloat velocityX = velocity.x;
		
		BOOL push = (velocityX < -kMinimumVelocity);
		push |= (velocityX > kMinimumVelocity);
		push |= ((self._lastDirection == CellSlideDirectionLeft && translation.x < -kMinimumPan) || (self._lastDirection == CellSlideDirectionRight && translation.x > kMinimumPan));
	
		push &= ((self._lastDirection == CellSlideDirectionRight && self._shouldDragRight) || (self._lastDirection == CellSlideDirectionLeft && self._shouldDragLeft)); 
		
		if (velocityX > 0 && self._lastDirection == CellSlideDirectionLeft)
			push = NO;
		
		else if (velocityX < 0 && self._lastDirection == CellSlideDirectionRight)
			push = NO;
		
		if (push && !self.hide) {
			
			[self _slideOutContentViewInDirection:self._lastDirection];
			
			
		} else if (self.hide && translation.x != 0) {
			CGFloat multiplier = self._bounceMultiplier;
			if (!self.hide)
				multiplier *= -1.0;
				
			[self _slideInContentViewFromDirection:self._currentDirection offsetMultiplier:multiplier];
			
			
		} else if (translation.x != 0) {
			// Figure out which side we've dragged on.
			CellSlideDirection finalDir = CellSlideDirectionRight;
			if (translation.x < 0)
				finalDir = CellSlideDirectionLeft;
		
			[self _slideInContentViewFromDirection:finalDir offsetMultiplier:-1.0 * self._bounceMultiplier];
			
		}
	}
}

- (BOOL)_shouldDragLeft
{
	return (self.direction == CellSlideDirectionBoth || self.direction == CellSlideDirectionLeft);
}

- (BOOL)_shouldDragRight
{
	return (self.direction == CellSlideDirectionBoth || self.direction == CellSlideDirectionRight);
}

- (CGFloat)_originalCenter
{
	return ceil(self.bounds.size.width / 2);
}

- (CGFloat)_bounceMultiplier
{
	return self.shouldBounce ? MIN(ABS(self._originalCenter - self.contentView.center.x) / kMinimumPan, 1.0) : 0.0;
}

#pragma mark - Sliding
#define kBOUNCE_DISTANCE 20.0

- (void)_slideInContentViewFromDirection:(CellSlideDirection)direction offsetMultiplier:(CGFloat)multiplier
{
	CGFloat bounceDistance;
	
	if (self.contentView.center.x == self._originalCenter)
		return;
	
	switch (direction) {
		case CellSlideDirectionRight:
			bounceDistance = kBOUNCE_DISTANCE * multiplier;
			break;
		case CellSlideDirectionLeft:
			bounceDistance = -kBOUNCE_DISTANCE * multiplier;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	
	[UIView animateWithDuration:0.1
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction 
					 animations:^{ self.contentView.center = CGPointMake(self._originalCenter, self.contentView.center.y); } 
					 completion:^(BOOL f) {
						 						 
						 [UIView animateWithDuration:0.1 delay:0 
											 options:UIViewAnimationCurveLinear
										  animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, bounceDistance, 0); } 
										  completion:^(BOOL f) {                     
											  
												  [UIView animateWithDuration:0.1 delay:0 
																	  options:UIViewAnimationCurveLinear
																   animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, -bounceDistance, 0); } 
																   completion:NULL];
										  }
						  ]; 
					 }];
    self.hide = NO;
    if ([self.delegate respondsToSelector:@selector(cellDidUnhide:)]){
        [self.delegate cellDidUnhide:self];        
    }

}

- (void)_slideOutContentViewInDirection:(CellSlideDirection)direction;
{
	CGFloat x;
	
	switch (direction) {
		case CellSlideDirectionLeft:
			x = - self._originalCenter;
			break;
		case CellSlideDirectionRight:
			x = self.contentView.frame.size.width + self._originalCenter;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	[UIView animateWithDuration:0.2 
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut 
					 animations:^{ self.contentView.center = CGPointMake(x, self.contentView.center.y); } 
					 completion:NULL];
    self.hide = YES;
    self._currentDirection = direction;
    if ([self.delegate respondsToSelector:@selector(cellDidHide:)]){
        [self.delegate cellDidHide:self];        
    }
}

- (void)_hideOutContentViewInDirection:(CellSlideDirection)direction;
{
	CGFloat x;
	switch (direction) {
		case CellSlideDirectionLeft:
			x = - self._originalCenter;
			break;
		case CellSlideDirectionRight:
			x = self.contentView.frame.size.width + self._originalCenter;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	self.contentView.center = CGPointMake(x, self.contentView.center.y);
    self._currentDirection = direction;
    self._lastDirection = direction;

}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == self._panGesture) {
		UIScrollView *superview = (UIScrollView *)self.superview;
		CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
		
		// Make sure it is scrolling horizontally
		return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO && (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
	}
	return NO;
}

@end
