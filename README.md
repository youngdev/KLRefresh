KLRefresh
=========

pull refresh &amp; push add

This is simple Pull & Push refresh
	by Glen
	From China BeiJing
	e-mail 36617161@qq.com

	You can use KLRefresh to project.	
	1) copy KLRefresh folder to your project;
	2) use [KLRefresh refreshWithScrollView:] init KLRefresh Class;
	3) if you want use Pull Refresh (Header) , you need set [isEnableHeader:Yes];
	4) if you want use Push Refresh (Footer) , you need set [isEnableFooter:Yes];
	5) you need set Delegate and method:
		- (void)refreshWillRefreshFromHeader{}
		- (void)refreshWillRefreshFromFooter{}
	6) if you complete Refresh Controller you need call mothed [endRefresh] update RefreshStatus;
