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
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    float centerY = rect.size.height/2;
    [_titleLabel setText:@"这里是标题"];
    [_detailLabel setText:@"这里是详细信息"];
    
    [_titleLabel sizeToFit];
    [_titleLabel setCenter:CGPointMake(self.center.x, centerY)];
    [_detailLabel sizeToFit];
    [_detailLabel setCenter:CGPointMake(self.center.x, centerY+10)];
    [_arrowImageView setCenter:CGPointMake(self.center.x, centerY+20)];
    
    [self addSubview:_titleLabel];
    [self addSubview:_detailLabel];
    
}

@end
