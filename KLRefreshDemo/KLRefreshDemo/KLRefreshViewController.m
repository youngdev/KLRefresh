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
    testTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [testTableView setDelegate:self];
    [testTableView setDataSource:self];
    [self.view addSubview:testTableView];
    

    refresh = [KLRefresh refreshWithScrollView:testTableView];      // init Refresh and set scrollview
    [refresh setIsEnableHeader:YES];        //enable header
    [refresh setIsEnableFooter:YES];        //enable footer
    [refresh setDelegate:self];     //delegate
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
