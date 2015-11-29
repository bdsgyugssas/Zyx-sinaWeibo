//
//  PlaceholdTextView.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/16.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholdTextView : UITextView

@property (strong, nonatomic) UIColor *placeholdColor;

@property (copy,nonatomic) NSString *placeholdText;

@property (strong, nonatomic) UIFont *Font;

@end
