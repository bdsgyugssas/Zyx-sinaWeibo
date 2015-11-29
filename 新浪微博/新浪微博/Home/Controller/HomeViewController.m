//
//  HomeViewController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/10.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "MenuView.h"
#import "dropDownMenuController.h"
#import "MenuView.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "Account.h"
#import "TitleMenuButton.h"
#import "MJExtension.h"
#import "Status.h"
#import "User.h"
#import "UIImageView+WebCache.h"
#import "WBStatusCell.h"
#import "StatusFrame.h"
#import "MJRefresh.h"
#import "StatusTool.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,MenuViewDelegate>

@property (strong, nonatomic) UIButton *titleButton;
/**
 *  获取最新的微博
 */
@property (strong, nonatomic) NSMutableArray *statusesFrame;

@end

@implementation HomeViewController
-(NSMutableArray *)statusesFrame
{
    if (_statusesFrame==nil) {
        _statusesFrame=[[NSMutableArray alloc]init];
    }
    return _statusesFrame;
}


- (void)viewDidLoad {
    

    [super viewDidLoad];
    
    self.tableView.backgroundColor=[UIColor colorWithRed:(double) 211/256 green:(double) 211/256 blue:(double) 211/256 alpha:1];
    
    [self getUserMessage];
    
    [self setNavigationItem];
    

    
    [self addRefreshControl];
    
    
    
    //获得未读数
//    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(getUnreadstatus) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];

}
/**
 *  获取用户未读取微博数
 */
-(void)getUnreadstatus
{

    
    Account *account=[AccountTool account];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
   
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    parameters[@"uid"]=account.uid;
    
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        NSString *count=[responseObject[@"status"] description];
        if ([count isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue=nil;
            [UIApplication  sharedApplication].applicationIconBadgeNumber=0;
        }else{
            self.tabBarItem.badgeValue=count;
            [UIApplication  sharedApplication].applicationIconBadgeNumber=count.intValue;
            NSLog(@"%d",[UIApplication  sharedApplication].applicationIconBadgeNumber);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {

    }];


}

                    
                    
                    
/**
 *  添加刷新控件
 */
-(void)addRefreshControl
{

    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshStatus:)];

    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放开始刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    self.tableView.header=header;
    
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoreData:)];
    [footer setTitle:@"加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    footer.automaticallyRefresh=NO;
    self.tableView.footer=footer;
    
    
    [self.tableView.header beginRefreshing];
    
    

}
/**
 *  上啦刷新 微博数据
 */
-(void)loadmoreData:(UIRefreshControl *)refreshControl
{
    Account *account=[AccountTool account];
    AFHTTPRequestOperationManager *mng=[AFHTTPRequestOperationManager manager];
    //https://api.weibo.com/2/statuses/friends_timeline.json
    StatusFrame *statusf=[self.statusesFrame lastObject];
    
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"access_token"]=account.access_token;
    dict[@"max_id"]=statusf.status.idstr;
    NSArray *array=[StatusTool statusWithParameter:dict];
    if (array.count) {
        NSArray *newArray=[Status mj_objectArrayWithKeyValuesArray:array];
        
        for (Status *status in newArray) {
            StatusFrame *statusframe=[[StatusFrame alloc]init];
            statusframe.status=status;
            [self.statusesFrame addObject:statusframe];
        }
        [self.tableView reloadData];
        [self.tableView.footer endRefreshing];
    }else{
    
        [mng GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [StatusTool saveStatus:responseObject[@"statuses"]];
        
        NSArray *newArray=[Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        for (Status *status in newArray) {
            StatusFrame *statusframe=[[StatusFrame alloc]init];
            statusframe.status=status;
            [self.statusesFrame addObject:statusframe];
        }
        
        
        [self.tableView reloadData];
        
        [self.tableView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"加载失败");
        [self.tableView.footer endRefreshing];

    }];
    }
    
    
    
    
}

/**
 *  下拉刷新 微博数据
 */
-(void)refreshStatus:(UIRefreshControl *)refreshControl
{
    
    self.tabBarItem.badgeValue=nil;
    Account *account=[AccountTool account];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    if (self.statusesFrame.count) {
        parameters[@"since_id"]=((StatusFrame *)self.statusesFrame.firstObject).status.idstr;
    }

    NSArray *array=[StatusTool statusWithParameter:parameters];
    
    if (array.count) {
        
        NSArray *newArray=[Status mj_objectArrayWithKeyValuesArray:array];

        for (Status *status in newArray) {
            StatusFrame *statusframe=[[StatusFrame alloc]init];
            statusframe.status=status;
            [self.statusesFrame addObject:statusframe];
        }

        [self.tableView reloadData];
        
        //[self showNewStatusCount:array.count];

        [refreshControl endRefreshing];

    }else {
        [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            [StatusTool saveStatus:responseObject[@"statuses"]];
            
            NSArray *newArray=[Status mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
   
            NSMutableArray *newstatusFrame=[NSMutableArray array];
            
            for (Status *status in newArray) {
                StatusFrame *statusframe=[[StatusFrame alloc]init];
                statusframe.status=status;
                [newstatusFrame addObject:statusframe];
            }
            
            NSIndexSet *set=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newArray.count)];
            
            [self.statusesFrame insertObjects:newstatusFrame atIndexes:set];
            
            [self.tableView reloadData];
            
            [self showNewStatusCount:newArray.count];
            
            [refreshControl endRefreshing];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            NSLog(@"获取用户的个人信息失败,原因：%@",error);
            
            [refreshControl endRefreshing];
            
        }];
    }

}

/**
 *  获取用户的个人信息
 */
-(void)getUserMessage
{
   //   https://api.weibo.com/2/users/show.json  get
   //   uid	  	int64	需要查询的用户ID。
   //   access_token		string
    
    Account *account=[AccountTool account];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"uid"]=account.uid;
    parameters[@"access_token"]=account.access_token;
    
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSString *name=responseObject[@"name"];
        account.name=name;
        [AccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"获取用户的个人信息失败,原因：%@",error);
    }];
    
    
}

/**
 *  设置导航栏信息
 */
-(void)setNavigationItem
{

    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemwithImage:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted" action:nil target:self];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemwithImage:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted" action:nil target:self];
    
    Account *account=[AccountTool account];

 
    TitleMenuButton *button=[[TitleMenuButton alloc]init];
    [button setTitle:account.name forState:UIControlStateNormal];
    [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];

        
    self.navigationItem.titleView=button;
    self.titleButton=button;
    


}



#pragma mark --私有方法
/**
 *  添加动画，显示加载的微博个数
 */
-(void)showNewStatusCount:(int)count
{

    UILabel *label=[[UILabel alloc]init];
    //label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.backgroundColor=[UIColor colorWithRed:1.0 green:(double)109/255 blue:0 alpha:0.9];
    label.textAlignment=NSTextAlignmentCenter;
    if (count==0) {
        label.text=@"没有新数据";
    }else{
        label.text=[NSString stringWithFormat:@"%d条新数据",count];
    }
    
    label.width=[UIScreen mainScreen].bounds.size.width;
    label.height=35;
    label.x=0;
    label.y=CGRectGetMaxY(self.navigationController.navigationBar.frame)-label.height;
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    float durationTime=1.0;
    [UIView animateWithDuration:durationTime animations:^{
        label.transform=CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:durationTime delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];

    }];
    
    
    
    
}
#pragma mark --titleClick
-(void)titleClick:(TitleMenuButton *)button
{
    button.selected=!button.isSelected;
    
    MenuView *menu=[MenuView menu];
    menu.delegate=self;
   
    dropDownMenuController *vc=[[dropDownMenuController alloc]init];
    vc.view.height=44*3;
    vc.view.width=150;
  
    menu.ContentController=vc;
   
    [menu showfrom:button];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusesFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    WBStatusCell *cell=[WBStatusCell cellWithTableView:tableView];

    cell.statusfarme=self.statusesFrame[indexPath.row];
    
    return cell;
}


#pragma mark --Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame=self.statusesFrame[indexPath.row];
    
    return statusFrame.cellHeight;
}

#pragma mark -
-(void)menuViewDidMiss:(MenuView *)menuView
{
    self.titleButton.selected=!self.titleButton.isSelected;
}



@end
