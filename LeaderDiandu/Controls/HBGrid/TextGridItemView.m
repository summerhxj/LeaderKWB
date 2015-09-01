//
//  TextGridItemView.m
//  HBGridView
//
//  Created by wxj on 12-10-12.
//  Copyright (c) 2012年 tt. All rights reserved.
//

#import "TextGridItemView.h"

@implementation TextGridItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        frame.origin = CGPointZero;
        _label = [[UILabel alloc] initWithFrame:frame];
        [self addSubview:_label];
        _label.textColor = [UIColor blackColor];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _label.text = text;
}

@end
