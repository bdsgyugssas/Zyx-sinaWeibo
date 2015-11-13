//
//  SearchBar.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {

        self.background=[UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder=@"请输入搜索条件";
        
        UIImageView *leftView=[[UIImageView alloc]init];
        leftView.image=[UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.size=CGSizeMake(30, 30);
        leftView.contentMode=UIViewContentModeCenter;
        self.leftView=leftView;
        self.leftViewMode=UITextFieldViewModeAlways;
    }

    return self;
}

+(instancetype)searchBar
{
    return [[self alloc]init];
}

@end
