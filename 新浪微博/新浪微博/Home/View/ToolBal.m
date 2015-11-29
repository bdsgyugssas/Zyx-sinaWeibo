//
//  TabBal.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/15.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "ToolBal.h"
#import "Status.h"

@implementation ToolBal


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        [self addbtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        [self addbtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        [self addbtnWithIcon:@"timeline_icon_unlike"  title:@"赞"];

    }
    return self;
}

-(void)addbtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:(double)180/256 green:(double)180/256 blue:(double)180/256 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:btn];
}
-(void)setStatus:(Status *)status
{

    _status=status;

    if (status.comments_count) {
        UIButton *button=self.subviews[0];
        [button setTitle:[NSString stringWithFormat:@"%d",status.comments_count] forState:UIControlStateNormal];

    }
    
    if (status.reposts_count) {
        UIButton *button=self.subviews[1];
        [button setTitle:[NSString stringWithFormat:@"%d",status.reposts_count] forState:UIControlStateNormal];
    }
    
    if (status.attitudes_count) {
        UIButton *button=self.subviews[2];
        [button setTitle:[NSString stringWithFormat:@"%d",status.attitudes_count] forState:UIControlStateNormal];
    }

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    int count=self.subviews.count;
    
    CGFloat buttonW=[UIScreen mainScreen].bounds.size.width/count;
    CGFloat buttonH=self.height;
    for (int i=0;i<count ; i++) {
        UIButton *button=self.subviews[i];
        CGFloat buttonX=i*buttonW;
        CGFloat buttonY=0;
        button.frame=CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
}

@end
