//
//  WBStatusCell.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/14.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StatusFrame;


@interface WBStatusCell : UITableViewCell

@property (strong, nonatomic) StatusFrame *statusfarme;

+(WBStatusCell *)cellWithTableView:(UITableView *)tableView;

@end
