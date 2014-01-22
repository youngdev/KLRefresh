KLRefresh
=========

This is simple Pull & Push refresh
	by Glen

	使用方法
	1) 复制 KLRefresh 文件夹到工程目录
	2) 使用 [KLRefresh refreshWithScrollView:<#UIScrollView#>] 进行初始化
	3) 如果你要使用 刷新功能 , 你需要设置 [isEnableHeader:Yes];
	4) 如果你要使用 加载功能 , 你需要设置 [isEnableFooter:Yes];
	5) 另外，你需要设置他们对应的 Delegate 
		- (void)refreshWillRefreshFromHeader{}
		- (void)refreshWillRefreshFromFooter{}
		//ps 为了不产生冲突,我把他们分开了
	6) 当你的项目刷新完成了，你需要调用 [endRefresh] 来更新 KLRefresh 的状态;


	说明
	  如果你的ScrollView 不满足滚动条件。那么你将无法使用Footer