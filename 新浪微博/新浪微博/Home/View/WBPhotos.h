//
//  WBPhotos.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/15.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WBPhotos : UIView

@property (strong, nonatomic) NSArray *photos;

+(CGSize)sizeWithCount:(int)count;

@end
