//
//  PlaceholdTextView.m
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/16.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import "PlaceholdTextView.h"

@implementation PlaceholdTextView


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)setFont:(UIFont *)Font
{
    [super setFont:Font];
    
    [self setNeedsDisplay];

}

-(void)textChange
{
    [self setNeedsDisplay];
}

-(void)setPlaceholdColor:(UIColor *)placeholdColor
{
    _placeholdColor=placeholdColor;
    
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    if (self.hasText)  return ;

    
    CGRect placeholdRect=CGRectMake(5, 8, self.width-2*5, self.height-2*10);
    NSMutableDictionary *attri=[NSMutableDictionary dictionary];
    attri[NSForegroundColorAttributeName]=self.placeholdColor;
    
    [self.placeholdText drawInRect:placeholdRect withAttributes:attri];



}
@end
