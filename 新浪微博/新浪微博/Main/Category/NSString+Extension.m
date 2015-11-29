//
//  NSString+Extension.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/15.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


-(CGSize)sizeWithfont:(UIFont *)font MaxW:(CGFloat)maxW
{
    NSMutableDictionary *Attributes=[NSMutableDictionary dictionary];
    Attributes[NSFontAttributeName]=font;
    
    return [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:Attributes context:nil].size;
}
-(CGSize)sizeWithfont:(UIFont *)font
{
    return [self sizeWithfont:font MaxW:MAXFLOAT];
}
@end
