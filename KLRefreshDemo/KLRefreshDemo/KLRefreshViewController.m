//
//  KLRefreshViewController.m
//  KoolearnLibrary
//
//  Created by Glen on 14-1-13.
//  Copyright (c) 2014年 Glen. All rights reserved.
//

#import "KLRefreshViewController.h"

@implementation KLRefreshViewController

- (id)init
{
    if ((self = [super init]))
    {
        if(!mydata)
            mydata = [[NSMutableArray alloc]init];
        [mydata removeAllObjects];
        for(int i=0;i<50;i++)
        {
            [mydata addObject:[NSString stringWithFormat:@"%d" , i]];
        }
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 适配 iOS7
    CGRect currentViewRect = self.view.bounds;
    int currentDeviceSystemVer = [[UIDevice currentDevice].systemVersion intValue];
    if(currentDeviceSystemVer>=7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        currentViewRect.size.height-=[UIApplication sharedApplication].statusBarFrame.size.height;
    }
    if(!self.navigationController.navigationBar.hidden)
        currentViewRect.size.height-=44;
    testTableView = [[UITableView alloc]initWithFrame:currentViewRect style:UITableViewStylePlain];
    [testTableView setDelegate:self];
    [testTableView setDataSource:self];
    [self.view addSubview:testTableView];
    

    
    // --- --- --- --- refresh --- --- --- --- ---
    refresh = [KLRefresh refreshWithScrollView:testTableView];      // init Refresh and set scrollview
    
    [refresh setIsEnableHeader:YES];        //enable header
    [refresh setHeaderArrowImage:[UIImage imageNamed:@"arrow2"]];        // set header Arrow image
    [refresh setHeaderBackgroundImage:[UIImage imageNamed:@"256"]];
    
    [refresh setIsEnableFooter:YES];        //enable footer
    [refresh setFooterArrowImage:[UIImage imageNamed:@"arrow2"]];        // set footer Arrow image
    [refresh setFooterBackgroundImage:[UIImage imageNamed:@"256"]];
    
    [refresh setDelegate:self];     //delegate
    // --- --- --- --- refresh --- --- --- --- ---
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark- RefreshDelegate
// Header
- (void)refreshWillRefreshFromHeader
{
//    refresh... and ReloadData View
//    if data update Complete , you need call [<$KLRefresh Instance$> endRefresh];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self endRef];
    });
}
//Footer
- (void)refreshWillRefreshFromFooter
{
//    add Data... and ReloadData View
//    if data update Complete , you need call [<$KLRefresh Instance$> endRefresh];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self endRef];
    });
}
- (void)endRef
{
    [refresh endRefresh];
}
#pragma mark- UITableViewDelegate & DataSource
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [cell.textLabel setText:[mydata objectAtIndex:indexPath.row]];
    return cell;
}

@end
