//
//  MLNavigationController.m
//  djApp
//
//  Created by jiang hu on 13-5-16.
//  Copyright (c) 2013年 dajie.com. All rights reserved.
//
#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#import "MLNavigationController.h"
#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGL.h>

#import "ViewCreatorHelper.h"
//#import "ReadBookViewController.h"

//#define USE_SWIPE_GESTURE

@interface MLNavigationController ()
{
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
#ifndef USE_SWIPE_GESTURE
    UIPanGestureRecognizer *recognizer;
#else
    UISwipeGestureRecognizer* swipeGesture;
#endif
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;
@end

@implementation MLNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];
        self.canDragBack = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    UIImage* leftShadowImage = [UIImage imageWithName:@"leftmenu_shadow.png" size:CGSizeMake(0.0f, self.view.frame.size.height)];
    UIImage* rightShadowImage = [UIImage imageWithName:@"filter_shadow.png" size:CGSizeMake(0.0f, self.view.frame.size.height)];
    if (leftShadowImage != nil) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:leftShadowImage];
        imageView.frame = CGRectMake(0-leftShadowImage.size.width, 0.0f, leftShadowImage.size.width, self.view.frame.size.height);
        [self.view addSubview:imageView];
    }
    if (rightShadowImage != nil) {
        UIImageView* imageView = [[UIImageView alloc] initWithImage:rightShadowImage];
        imageView.frame = CGRectMake(self.view.frame.size.width, 0.0f, rightShadowImage.size.width, self.view.frame.size.height);
        [self.view addSubview:imageView];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
//    self.view.layer.shadowOffset = CGSizeMake(5, 5);
//    self.view.layer.shadowRadius = 5;
//    self.view.layer.shadowOpacity = 1;
    
#ifndef USE_SWIPE_GESTURE
    recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    recognizer.delegate = self;
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
#else
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureReceive:)];
    swipeGesture.delegate = self;
    [swipeGesture delaysTouchesBegan];
    [self.view addGestureRecognizer:swipeGesture];
#endif
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
#ifndef USE_SWIPE_GESTURE
    [self.view removeGestureRecognizer:recognizer];
#else
    [self.view removeGestureRecognizer:swipeGesture];
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [self.screenShotsList removeAllObjects];
    self.screenShotsList = nil;
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
}
// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated) {
        [self pushViewController:viewController];
    }else{
        [self.screenShotsList addObject:[self capture]];
        [super pushViewController:viewController animated:animated];
    }
}
// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}
-(void) popViewController{
    if (!self.backgroundView)
    {
        CGRect frame = self.view.frame;
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
        
        blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:blackMask];
    }
    self.backgroundView.hidden = NO;
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    UIImage *lastScreenShot = [self.screenShotsList lastObject];
    lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    [self moveViewWithX:0];
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:320];
    } completion:^(BOOL finished) {
        [self popViewControllerAnimated:NO];
        CGRect frame = self.view.frame;
        frame.origin.x = 0;
        self.view.frame = frame;
    }];
}

- (void)pushViewController:(UIViewController *)viewController{
    CGRect frame = self.view.frame;
    if (!self.backgroundView)
    {
        self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
        
        blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:blackMask];
    }
    UIImage* img =[self capture];
    [self.screenShotsList addObject:img];
    if (!lastScreenShotView){
         lastScreenShotView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    }
    [lastScreenShotView setImage:img];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
    self.backgroundView.hidden = NO;
    [self moveViewWithX:320];
    [super pushViewController:viewController animated:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self moveViewWithX:0];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture
{
    CGRect rect = self.view.frame;
    //UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage* img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    
//    NSLog(@"Move to:%f",x);
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/600);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

#ifndef USE_SWIPE_GESTURE

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        CGRect frame = self.view.frame;
        if (!self.backgroundView)
        {
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        if (!lastScreenShotView){
            lastScreenShotView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        }
        [lastScreenShotView setImage:[self.screenShotsList lastObject]];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 120)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}


#else

- (void)swipeGestureReceive:(UISwipeGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:self.view];
    
    NSLog(@"======================state:%d", recoginzer.state);
    NSLog(@"======================derection:%d", recoginzer.direction);
    NSLog(@"======================point:%f,%f", touchPoint.x,touchPoint.y);
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        CGRect frame = self.view.frame;
        if (!self.backgroundView)
        {
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        if (!lastScreenShotView){
            lastScreenShotView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        }
        [lastScreenShotView setImage:[self.screenShotsList lastObject]];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

#endif


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if (self.viewControllers.count <= 1 || !self.canDragBack || [[self.viewControllers lastObject] isKindOfClass:[ReadBookViewController class]]) {
//        return NO;
//    }
//    else {
//        return YES;
//    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
//    NSString* strClass = NSStringFromClass([otherGestureRecognizer.view class]);

    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        UITableView* table = (UITableView*)otherGestureRecognizer.view;
        if (table.editing) {
            gestureRecognizer.enabled = NO;
            gestureRecognizer.enabled = YES;
        }
        return NO;
    }
    else if ([otherGestureRecognizer.view isKindOfClass:[UITableViewCell class]]) {
        return NO;
    }
//    else if ([otherGestureRecognizer.view isKindOfClass:[SevenSwitch class]]) {
//        return NO;
//    }
    else if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        if (otherGestureRecognizer.view.frame.size.height > 300) {
            return NO;
        }
        else {
            return YES;
        }
    }
//    else if ([strClass isEqualToString:@"UIScrollView"]) {
//        return NO;
//    }
    else {
        return YES;
    }
}

@end
