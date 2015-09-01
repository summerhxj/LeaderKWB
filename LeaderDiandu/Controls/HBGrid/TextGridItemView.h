//
//  TextGridItemView.h
//  HBGridView
//
//  Created by wxj on 12-10-12.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import "HBGridItemView.h"

@interface TextGridItemView : HBGridItemView
{
    UILabel *_label;
}

- (void)setText:(NSString *)text;

@end
