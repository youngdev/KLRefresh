//
//  KLRefreshViewController.h
//  KoolearnLibrary
//
//  Created by Glen on 14-1-13.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLRefresh.h"
@interface KLRefreshViewController : UIViewController<KLRefreshDelegate , UITableViewDataSource , UITableViewDelegate>
{
    UITableView *testTableView;
    NSMutableArray *mydata;
    KLRefresh *refresh;
}
@end
