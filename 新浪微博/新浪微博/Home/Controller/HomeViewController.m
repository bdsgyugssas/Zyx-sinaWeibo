//
//  HomeViewController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/10.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "HomeViewController.h"
#import "View1Controller.h"
#import "UIBarButtonItem+Extension.h"
#import "MenuView.h"
#import "dropDownMenuController.h"
#import "MenuView.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "Account.h"
#import "TitleMenuButton.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,MenuViewDelegate>

@property (strong, nonatomic) UIButton *titleButton;


@end

@implementation HomeViewController



- (void)viewDidLoad {
    

    [super viewDidLoad];
    
    [self getUserMessage];
    
    [self setNavigationItem];
    
    [self loadNewStatus];
    

}
/**
 *  加载最新的微博信息
 */
-(void)loadNewStatus
{
    Account *account=[AccountTool account];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"access_token"]=account.access_token;
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"获取用户的个人信息失败,原因：%@",error);
    }];

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
    NSLog(@"1111");
    self.titleButton=button;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    View1Controller *view1Con=[[View1Controller alloc]init];
    view1Con.title=@"测试";

    [self.navigationController pushViewController:view1Con animated:YES];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // Configure the cell...
    
    cell.textLabel.text=[NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}

#pragma mark -
-(void)menuViewDidMiss:(MenuView *)menuView
{
    self.titleButton.selected=!self.titleButton.isSelected;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
