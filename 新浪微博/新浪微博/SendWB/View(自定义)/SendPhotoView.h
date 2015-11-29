//
//  SendPhotoView.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendPhotoView : UIView

-(void)addPhoto:(UIImage *)photo;

@property (strong, nonatomic,readonly) NSMutableArray *photos;

@end
