//
//  UIBarButtonItem+Extension.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemwithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage action:(SEL)action target:(id) target
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.size=button.currentImage.size;
    NSLog(@"111");
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
}
@end
