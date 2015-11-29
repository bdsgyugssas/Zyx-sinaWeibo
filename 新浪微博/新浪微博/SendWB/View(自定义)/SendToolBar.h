//
//  SendToolBar.h
//  新浪微博
//
//  Created by 郑雨鑫 on 15/11/17.
//  Copyright © 2015年 郑雨鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendToolBar;
typedef enum {
    sendToolBarButtonItemCamera, 
    sendToolBarButtonItemPicture,
    sendToolBarButtonItemKeyboard,
    sendToolBarButtonItemMention,
    sendToolBarButtonItemEmoticon
} sendToolBarButtonItemType;

@protocol SendToolBarDelegate <NSObject>

-(void)buttonClickOfSendToolBar:(SendToolBar *)sendToolBar withButtonType:(sendToolBarButtonItemType)type;

@end

@interface SendToolBar : UIView

@property (weak, nonatomic) id <SendToolBarDelegate> delegate;

@property (assign, nonatomic) BOOL showEmotionButton;

@end
