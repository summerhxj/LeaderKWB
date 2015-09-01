//
//  HBBaseViewController.m
//  LeaderDiandu
//
//  Created by hxj on 15/8/26.
//
//

#import "HBBaseViewController.h"

@interface HBBaseViewController ()
{
    
}

@end

@implementation HBBaseViewController

-(void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self willPop];
    [super dismissViewControllerAnimated:flag completion:completion];
}

-(void)willPop{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation HBBaseViewController(CallBack)

@end
