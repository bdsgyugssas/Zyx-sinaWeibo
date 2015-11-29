//
//  ProfileViewController.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/10.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

//-(void)setView:(UIView *)view
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *button=[[UIBarButtonItem alloc]initWithTitle:@"清除缓存" style:UIBarButtonItemStylePlain target:self action:@selector(cleancache)];
    self.navigationItem.rightBarButtonItem=button;

}



-(void)cleancache
{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    NSFileManager *manager=[NSFileManager defaultManager];
    NSInteger count=0;
    NSArray *array1=[manager subpathsAtPath:cachePath];
    for (NSString * subpath in array1) {
        NSString *path=[cachePath stringByAppendingPathComponent:subpath];
        BOOL isirectory;
        [manager fileExistsAtPath:path isDirectory:&isirectory];
        if (!isirectory) {
             count+=[[manager attributesOfItemAtPath:path error:nil][NSFileSize] integerValue];
        }
    }

    self.navigationItem.title=[NSString stringWithFormat:@"缓存大小为%.1fM",(double)count/1000/1000];
    
    [manager removeItemAtPath:cachePath error:nil];

}

-(void)viewWillAppear:(BOOL)animated
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
