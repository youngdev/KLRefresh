//
//  KLRefresh.h
//  KoolearnLibrary
//
//  Created by Glen on 14-1-9.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#define kRefreshHeaderDistance 50.0
#define kRefreshHeaderStatusA @"下拉即可刷新"
#define kRefreshHeaderStatusB @"释放即可刷新"
#define kRefreshHeaderStatusC @"刷新中..."

#define kRefreshFooterDistance 50.0
#define kRefreshFooterStatusA @"上推即可加载"
#define kRefreshFooterStatusB @"释放即可加载"
#define kRefreshFooterStatusC @"刷新中..."

#import <UIKit/UIKit.h>
#import "KLRefreshHeader.h"
#import "KLRefreshFooter.h"

typedef enum{
    RefreshStatusNormal,
    RefreshStatusDidDragging,
    RefreshStatusWillRelease,
    RefreshStatusDidRelease
}RefreshStatus;

@class KLRefresh;
@protocol KLRefreshDelegate <NSObject>
@optional
- (void)refreshWillRefreshFromHeader;
- (void)refreshWillRefreshFromFooter;
@end

@interface KLRefresh : UIView < UIScrollViewDelegate >
{
    KLRefreshHeader *header;
    KLRefreshFooter *footer;
    RefreshStatus refreshStatus;
    UIActivityIndicatorView *activity;
    BOOL valid;
}
@property (nonatomic , assign) id <KLRefreshDelegate> delegate;
@property (nonatomic , strong) UIScrollView *scroller;
@property (nonatomic , strong) UIImage *headerArrowImage;
@property (nonatomic , strong) UIImage *headerBackgroundImage;
@property (nonatomic , strong) UIImage *footerArrowImage;
@property (nonatomic , strong) UIImage *footerBackgroundImage;

@property (nonatomic)BOOL isEnableHeader;
@property (nonatomic)BOOL isEnableFooter;
@property (nonatomic)BOOL isRefreshing;

+ (KLRefresh *)refreshWithScrollView:(UIScrollView *)scrollView;
- (void)endRefresh;
@end
