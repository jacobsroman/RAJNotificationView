//
//  RAJNotificationView.h
//  Discontimo
//
//  Created by RaMan on 03.02.16.
//  Copyright © 2016 CEIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RAJNotificationView : UIView

typedef NS_ENUM(NSInteger, RAJNovificationVerticalAlligment){
    RAJAlligentTop = 0,
    RAJAlligentCenter = 1,
    RAJAlligentBottom = 2
};

+ (void)showNotificationWithMessage:(NSString*)message;

+ (void)showNotificationWithMessage:(NSString*)message
                          alligment:(RAJNovificationVerticalAlligment)alligment;

+ (void)showSuccessNotificationWithMessage:(NSString*)message;
+ (void)showFailureNotificationWithMessage:(NSString*)message;

+ (void)showNotificationWithMessage:(NSString*)message
                               icon:(UIImage*)icon;

+ (void)showNotificationWithMessage:(NSString*)message
                               font:(UIFont*)font;

+ (void)showNotificationWithMessage:(NSString*)message
                               font:(UIFont*)font
                               icon:(UIImage*)icon;

+ (void)showNotificationWithMessage:(NSString *)message
                          textColor:(UIColor*)textColor
                    backgroundColor:(UIColor*)backgroundColor;

+ (void)showSuccessNotificationWithMessage:(NSString*)message
                           backGroundColor:(UIColor*)bgColor
                                 textColor:(UIColor*)textColor
                                      icon:(UIImage*)icon
                                      font:(UIFont*)font
                                 alligment:(RAJNovificationVerticalAlligment)alligment;

@property (strong, nonatomic) UILabel* messageLabel;
@property (strong, nonatomic) UIImageView* iconView;

@end
