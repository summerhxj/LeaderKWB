//
//  HBGradeViewController.m
//  LeaderDiandu
//
//  Created by xijun on 15/8/26.
//  Copyright (c) 2015年 hxj. All rights reserved.
//

#import "HBGradeViewController.h"
#import "UIViewController+AddBackBtn.h"
#import "HBTitleView.h"
#import "DHSlideMenuController.h"
#import "HBGridView.h"
#import "TextGridItemView.h"
#import "HBDataSaveManager.h"
#import "HBServiceManager.h"
#import "HBContentManager.h"
#import "HBContentEntity.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define DataSourceCount 10

@interface HBGradeViewController ()<HBGridViewDelegate>
{
    HBGridView *_gridView;
    NSMutableArray *_dataSource;
}

@property (nonatomic, strong)NSMutableArray *contentEntityArr;

@end

@implementation HBGradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initMainView];
    [self initMainGrid];
    [self initButton];
    //获取所有可选套餐
    [self requestAllBookset];
}

- (void)initMainView
{
    HBTitleView *labTitle = [HBTitleView titleViewWithTitle:@"课外宝" onView:self.view];
    [self.view addSubview:labTitle];
}

- (void)initMainGrid
{
    _gridView = [[HBGridView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, ScreenHeight)];
    _gridView.delegate = self;
    [self.view addSubview:_gridView];
    
    _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSInteger index = 0; index < DataSourceCount; ++index)
    {
        [_dataSource addObject:[NSNumber numberWithInteger:index]];
    }
}

- (void)initButton
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8, 20, 44, 44)];
    [button setBackgroundImage:[UIImage imageNamed:@"ToggleMenu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ToggleMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)ToggleMenuPressed:(id)sender
{
    [[DHSlideMenuController sharedInstance] showLeftViewController:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark HBGridViewDelegate

// 获取单元格的总数
- (NSInteger)gridNumberOfGridView:(HBGridView *)gridView
{
    return [_dataSource count];
}

// 获取gridview每行显示的grid数
- (NSInteger)columnNumberOfGridView:(HBGridView *)gridView
{
    return 3;
}

// 获取单元格的行数
- (NSInteger)rowNumberOfGridView:(HBGridView *)gridView
{
    if ([_dataSource count] % [self columnNumberOfGridView:gridView])
    {
        return [_dataSource count] / [self columnNumberOfGridView:gridView] + 1;
    }
    else
    {
        return [_dataSource count] / [self columnNumberOfGridView:gridView];
    }
}

- (CGFloat)gridView:(HBGridView *)gridView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight / 3.0f;
}

// 获取特定位置的单元格视图
- (HBGridItemView *)gridView:(HBGridView *)gridView inGridCell:(HBGridCellView *)gridCell gridItemViewAtGridIndex:(GridIndex *)gridIndex listIndex:(NSInteger)listIndex
{
    NSLog(@"list index:%ld", listIndex);
    TextGridItemView *itemView = (TextGridItemView *)[gridView dequeueReusableGridItemAtGridIndex:gridIndex ofGridCellView:gridCell];
    if (!itemView)
    {
        itemView = [[TextGridItemView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/3, ScreenHeight/3)];
    }
    itemView.backgroundColor = [UIColor grayColor];
    NSDictionary * targetData = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 @"美妙早餐", TextGridItemView_BookName,
                                 @"mainGrid_defaultBookCover", TextGridItemView_BookCover,
                                 @"mainGrid_download", TextGridItemView_downloadState,
                                 nil];
    [itemView updateFormData:targetData];
    return itemView;
}

- (void)gridView:(HBGridView *)gridView didSelectGridItemAtIndex:(NSInteger)index
{
    HBGridItemView *itemView = [gridView gridItemViewAtIndex:index];
    itemView.backgroundColor = [UIColor redColor];
}

- (void)requestAllBookset
{
    NSDictionary *dict = [[HBDataSaveManager defaultManager] loadUser];
    if (dict) {
        NSString *user = [dict objectForKey:@"name"];
        NSString *token = [dict objectForKey:@"token"];
        //获取所有可选套餐
        [[HBServiceManager defaultManager] requestAllBookset:user token:token completion:^(id responseObject, NSError *error) {
            if (responseObject) {
                //获取所有可选套餐成功
                self.contentEntityArr = [[NSMutableArray alloc] initWithCapacity:1];
                NSArray *arr = [responseObject objectForKey:@"booksets"];
                for (NSDictionary *dict in arr)
                {
                    HBContentEntity *contentEntity = [[HBContentEntity alloc] initWithDictionary:dict];
                    [self.contentEntityArr addObject:contentEntity];
                }
                
                HBContentEntity *contentEntity = [self.contentEntityArr objectAtIndex:0];
                
                [[HBContentManager defaultManager] requestBookList:contentEntity.free_books completion:^(id responseObject, NSError *error) {
                    
                    //to do ...
                }];
            }
        }];
    }
}


@end
