//
//  KLRefreshHeader.m
//  KoolearnLibrary
//
//  Created by Glen on 14-1-9.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import "KLRefreshHeader.h"

@implementation KLRefreshHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor brownColor]];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.f]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        [_detailLabel setBackgroundColor:[UIColor clearColor]];
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    return self;
}
- (void)setBackgroundImage:(UIImage *)img
{
    if(!bgImg)
        bgImg = [[UIImageView alloc]initWithImage:img];
    else
        [bgImg setImage:img];
    [self addSubview:bgImg];
    [self sendSubviewToBack:bgImg];
}
- (void)drawRect:(CGRect)rect
{
    [bgImg setFrame:rect];
    float centerY = abs(self.center.y);
    [_titleLabel sizeToFit];
    [_detailLabel sizeToFit];
    [_titleLabel setCenter:CGPointMake(self.center.x, centerY)];
    [_detailLabel setCenter:CGPointMake(self.center.x, centerY+10)];
    [_arrowImageView setCenter:CGPointMake(self.center.x-50, centerY)];
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    [self addSubview:_arrowImageView];
}

@end
