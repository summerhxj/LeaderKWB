//
//  MLNavigationController.h
//  djApp
//
//  Created by jiang hu on 13-5-16.
//  Copyright (c) 2013年 dajie.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLNavigationController : UINavigationController<UIGestureRecognizerDelegate>
@property (nonatomic,assign) BOOL canDragBack;
- (void)pushViewController:(UIViewController *)viewController;
-(void) popViewController;
@end
