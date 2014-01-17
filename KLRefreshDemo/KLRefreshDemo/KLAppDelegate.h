//
//  KLAppDelegate.h
//  KLRefreshDemo
//
//  Created by Glen on 14-1-17.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLRefreshViewController.h"

@interface KLAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) KLRefreshViewController *rootViewController;
@property (strong, nonatomic) UIWindow *window;

@end
