//
//  User.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/13.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "User.h"

@implementation User

-(void)setMbtype:(int)mbtype
{
    _mbtype=mbtype;
    
    if (_mbtype>2) {
        self.VIP=YES;
    }
}

@end
