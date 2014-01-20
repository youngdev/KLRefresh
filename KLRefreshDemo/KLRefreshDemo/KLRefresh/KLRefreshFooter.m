//
//  KLRefreshFooter.m
//  KoolearnLibrary
//
//  Created by Glen on 14-1-9.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import "KLRefreshFooter.h"

@implementation KLRefreshFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor redColor]];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    float centerY = rect.size.height/2;
    [_titleLabel sizeToFit];
    [_detailLabel sizeToFit];
    [_titleLabel setCenter:CGPointMake(self.center.x, centerY)];
    [_detailLabel setCenter:CGPointMake(self.center.x, centerY+10)];
    [_arrowImageView setCenter:CGPointMake(self.center.x, centerY+20)];
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    
}

@end
