//
//  KLRefresh.m
//  KoolearnLibrary
//
//  Created by Glen on 14-1-9.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import "KLRefresh.h"
#import <math.h>
static KLRefresh *instance;
@implementation KLRefresh

- (id)init
{
    if((self = [super init]))
    {
        valid = YES;
    }
    return self;
}

+ (KLRefresh *)refreshWithScrollView:(UIScrollView *)scrollView
{
    if(!instance)
        instance = [[KLRefresh alloc] init];
    [instance setScroller:scrollView];
    
    [scrollView setDelegate:instance];
    return instance;
}

- (void)setScroller:(UIScrollView *)scroller
{
    _scroller = scroller;
}

- (void)setIsEnableHeader:(BOOL)isEnableHeader
{
    _isEnableHeader = isEnableHeader;
    header = [[KLRefreshHeader alloc]initWithFrame:CGRectMake(0, -kRefreshHeaderDistance, _scroller.bounds.size.width, kRefreshHeaderDistance)];
    [header.titleLabel setText:kRefreshHeaderStatusA];
    [_scroller addSubview:header];
}
- (void)setHeaderArrowImage:(UIImage *)headerArrowImage
{
    if(header)
    {
        [header.arrowImageView setImage:headerArrowImage];
        [header.arrowImageView setBounds:CGRectMake(0, 0, headerArrowImage.size.width, headerArrowImage.size.height)];
    }
}
- (void)setHeaderBackgroundImage:(UIImage *)headerBackgroundImage
{
    _headerBackgroundImage = headerBackgroundImage;
    [header setBackgroundImage:headerBackgroundImage];
}
- (void)setFooterBackgroundImage:(UIImage *)footerBackgroundImage
{
    _footerBackgroundImage = footerBackgroundImage;
    [footer setBackgroundImage:footerBackgroundImage];
}
- (void)setIsEnableFooter:(BOOL)isEnableFooter
{
    _isEnableFooter = isEnableFooter;
    footer = [[KLRefreshFooter alloc]initWithFrame:CGRectMake(0, _scroller.contentSize.height, _scroller.bounds.size.width, kRefreshFooterDistance)];
    [footer.titleLabel setText:kRefreshFooterStatusA];
    [_scroller addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)setFooterArrowImage:(UIImage *)footerArrowImage
{
    if(footer)
    {
        [footer.arrowImageView setImage:footerArrowImage];
        [footer.arrowImageView setBounds:CGRectMake(0, 0, footerArrowImage.size.width, footerArrowImage.size.height)];
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(![_scroller.subviews containsObject:_scroller] && _scroller.contentSize.height>_scroller.bounds.size.height)
        [_scroller addSubview:footer];
    [footer setFrame:CGRectMake(0, _scroller.contentSize.height, _scroller.bounds.size.width, kRefreshFooterDistance)];
}

- (void)endRefresh
{
    [self changeStatus:RefreshStatusNormal];
    [self replaceArrowImage:header.arrowImageView withLoadingInView:header];
    [self replaceArrowImage:footer.arrowImageView withLoadingInView:footer];
    [UIView animateWithDuration:.2f animations:^{
        [_scroller setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }];
    valid = YES;
}

- (void)changeStatus:(RefreshStatus)newRefreshStatus
{
    refreshStatus = newRefreshStatus;
}
- (void)transformArrowImg:(UIImageView *)imgView
{
    [UIView animateWithDuration:0.2f animations:^{
        imgView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}
- (void)transformArrowImg2:(UIImageView *)imgView
{
    [UIView animateWithDuration:0.2f animations:^{
        imgView.transform = CGAffineTransformMakeRotation(0);
    }];
}
- (void)replaceArrowImage:(UIImageView *)imgView withLoadingInView:(UIView *)view
{
    if(!activity)
    {
        activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activity.frame =imgView.frame;
        [activity startAnimating];
    }
    if(refreshStatus == RefreshStatusDidRelease)
    {
        [imgView setAlpha:0.f];
        [view addSubview:activity];
    }
    else
    {
        [imgView setAlpha:1.f];
        [activity removeFromSuperview];
    }
}
#pragma mark- UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!valid)
        return;
    int height = scrollView.contentOffset.y;
    int contentHeight =scrollView.contentSize.height-scrollView.frame.size.height;
    if (height>contentHeight && _isEnableFooter)
    {
        int footHeight =kRefreshFooterDistance+contentHeight;
        if(height>=footHeight && refreshStatus == RefreshStatusDidDragging)
        {
            [self changeStatus:RefreshStatusWillRelease];
            [self transformArrowImg2:footer.arrowImageView];
            [footer.titleLabel setText:kRefreshFooterStatusB];
        }
        else if(height<footHeight && height>contentHeight)
        {
            [self changeStatus:RefreshStatusDidDragging];
            [self transformArrowImg:footer.arrowImageView];
            [footer.titleLabel setText:kRefreshFooterStatusA];
        }
    }
    if (height<0 && _isEnableHeader)
    {
        height = abs(height);
        if(height>=kRefreshHeaderDistance && refreshStatus == RefreshStatusDidDragging)
        {
            [self changeStatus:RefreshStatusWillRelease];
            [self transformArrowImg:header.arrowImageView];
            [header.titleLabel setText:kRefreshHeaderStatusB];
        }
        else if(height<kRefreshHeaderDistance)
        {
            [self changeStatus:RefreshStatusDidDragging];
            [self transformArrowImg2:header.arrowImageView];
            [header.titleLabel setText:kRefreshHeaderStatusA];
        }
    }
        return;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!valid)
        return;
    if(refreshStatus == RefreshStatusWillRelease && scrollView.contentOffset.y<0)
    {
        [self changeStatus:RefreshStatusDidRelease];
        [self replaceArrowImage:header.arrowImageView withLoadingInView:header];
        [self transformArrowImg2:header.arrowImageView];
        [header.titleLabel setText:kRefreshHeaderStatusC];
        [UIView animateWithDuration:.2f animations:^{
            [scrollView setContentInset:UIEdgeInsetsMake(kRefreshHeaderDistance, 0, 0, 0)];
        }];
        if(_delegate && [_delegate respondsToSelector:@selector(refreshWillRefreshFromHeader)])
        {
            [_delegate refreshWillRefreshFromHeader];
            valid = NO;
        }
    }
    else if(refreshStatus == RefreshStatusWillRelease && scrollView.contentOffset.y>0)
    {
        [self changeStatus:RefreshStatusDidRelease];
        [self replaceArrowImage:footer.arrowImageView withLoadingInView:footer];
        [self transformArrowImg:footer.arrowImageView];
        [footer.titleLabel setText:kRefreshHeaderStatusC];
        [UIView animateWithDuration:.2f animations:^{
            [scrollView setContentInset:UIEdgeInsetsMake(0, 0, kRefreshFooterDistance, 0)];
        }];
        if(_delegate && [_delegate respondsToSelector:@selector(refreshWillRefreshFromFooter)])
        {
            [_delegate refreshWillRefreshFromFooter];
            valid = NO;
        }
    }
}
@end
