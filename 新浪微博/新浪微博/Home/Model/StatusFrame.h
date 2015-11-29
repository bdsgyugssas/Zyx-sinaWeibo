//
//  StatusFrame.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/14.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

#define NameFont [UIFont systemFontOfSize:14]
//*  微博时间 字体*/
#define CreateTimeFont [UIFont systemFontOfSize:11]
//*  微博美容 字体*/
#define TextFont [UIFont systemFontOfSize:14]
//*  转发微博 文本字体*/
#define retweetTextFont [UIFont systemFontOfSize:11]


#define  cellBorder  10

@interface StatusFrame : NSObject

/**    原创微博内容位置     */
@property (assign, nonatomic) CGRect originalViewFrame;
/**    微博头像位置     */
@property (assign, nonatomic) CGRect iconViewFrame;
/**    微博配图位置     */
@property (assign, nonatomic) CGRect photoViewFrame;
/**    微博VIP图片位置     */
@property (assign, nonatomic) CGRect VIPViewFrame;
/**    微博作者位置    */
@property (assign, nonatomic) CGRect nameFrame;
/**    微博发布时间位置     */
@property (assign, nonatomic) CGRect create_timeFrame;
/**    微博内容位置    */
@property (assign, nonatomic) CGRect textFrame;
/**    微博内容    */
@property (strong, nonatomic) Status *status;
/**    微博来源    */
@property (assign, nonatomic) CGRect sourceFrame;
/**    cell的高度  */
@property (assign, nonatomic) CGFloat cellHeight;

//转发微博
/**    转发微博     */
@property (assign, nonatomic) CGRect retweetViewFrame;
/**    转发微博内容+昵称     */
@property (assign, nonatomic) CGRect retweetTextFrame;
/**    转发微博图片     */
@property (assign, nonatomic) CGRect retweetPhotoViewFrame;

/**  工具条 */
@property (assign, nonatomic) CGRect toolBarFrame;

@end
