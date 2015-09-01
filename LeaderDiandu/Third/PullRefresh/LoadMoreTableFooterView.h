//
//  LoadMoreTableFooterView.h
//
//  Created by Ye Dingding on 10-12-24.
//  Copyright 2010 Intridea, Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

#define LoadMorePullingString_Default   @"松手加载更多"
#define LoadMoreNormalString_Default    @"上拉加载更多"
#define LoadMoreLoadingString_Default   @"加载中..."

typedef enum{
	LoadMorePulling = 0,
	LoadMoreNormal,
	LoadMoreLoading,	
} LoadMoreState;

@protocol LoadMoreTableFooterDelegate;
@interface LoadMoreTableFooterView : UIView {
	id __unsafe_unretained _delegate;
	LoadMoreState _state;
	
	UILabel *_statusLabel;
	UIActivityIndicatorView *_activityView;
}

@property(nonatomic,assign) id <LoadMoreTableFooterDelegate> delegate;
@property(nonatomic,assign, setter = setLoadMoreHeight:) CGFloat loadMoreHeight;
@property(nonatomic,assign) UIScrollView *scrollView;

@property(nonatomic,strong) NSString *loadMorePullingString;
@property(nonatomic,strong) NSString *loadMoreNormalString;
@property(nonatomic,strong) NSString *loadMoreLoadingString;

-(void)addArrowPic:(BOOL)isAdd;
-(BOOL)isNeedLoadMoreHeightWithScrollView:(UIScrollView*)scrollViewT;
- (void)loadMoreScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)loadMoreScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)loadMoreScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
- (void)loadMoreSCrollViewWithFailNet:(UIScrollView *)scrollView;
@end

@protocol LoadMoreTableFooterDelegate
- (void)loadMoreTableFooterDidTriggerRefresh:(LoadMoreTableFooterView *)view;
- (BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view;
@end
