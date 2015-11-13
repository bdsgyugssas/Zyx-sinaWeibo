//
//  UIBarButtonItem+Extension.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/11.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemwithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage action:(SEL)action target:(id) target;

@end
