//
//  RAJNotificationView.m
//  Discontimo
//
//  Created by RaMan on 03.02.16.
//  Copyright © 2016 CEIT. All rights reserved.
//

#import "RAJNotificationView.h"

#define kNotificationViewIndent 24
#define kNotificationLabelIndent 8
#define kIconWidth 24

#define kShowingTime 2

#define kDefaultBackgroundColor [[UIColor whiteColor]colorWithAlphaComponent:0.9]

#define kDefaultSuccessColor [[UIColor greenColor]colorWithAlphaComponent:0.9]
#define kDefaultFailureColor [[UIColor redColor]colorWithAlphaComponent:0.9]

#define kDefaultTextColor [UIColor blackColor]

@implementation RAJNotificationView


+ (void)showNotificationWithMessage:(NSString*)message
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultBackgroundColor
                                                  textColor:kDefaultTextColor
                                                       icon:nil
                                                       font:nil
                                                  alligment:RAJAlligentTop];
}

+ (void)showNotificationWithMessage:(NSString*)message
                          alligment:(RAJNovificationVerticalAlligment)alligment
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultBackgroundColor
                                                  textColor:kDefaultTextColor
                                                       icon:nil
                                                       font:nil
                                                  alligment:alligment];
}


+ (void)showSuccessNotificationWithMessage:(NSString*)message
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultSuccessColor
                                                  textColor:kDefaultTextColor
                                                       icon:nil
                                                       font:nil
                                                  alligment:RAJAlligentTop];
}

+ (void)showFailureNotificationWithMessage:(NSString*)message
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultFailureColor
                                                  textColor:kDefaultTextColor
                                                       icon:nil
                                                       font:nil
                                                  alligment:RAJAlligentTop];
}


+ (void)showNotificationWithMessage:(NSString*)message
                               icon:(UIImage*)icon
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultBackgroundColor
                                                  textColor:kDefaultTextColor
                                                       icon:icon
                                                       font:nil
                                                  alligment:RAJAlligentTop];
}


+ (void)showNotificationWithMessage:(NSString*)message
                               font:(UIFont*)font
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultBackgroundColor
                                                  textColor:kDefaultTextColor
                                                       icon:nil
                                                       font:font
                                                  alligment:RAJAlligentTop];
}


+ (void)showNotificationWithMessage:(NSString*)message
                               font:(UIFont*)font
                               icon:(UIImage*)icon
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:kDefaultBackgroundColor
                                                  textColor:kDefaultTextColor
                                                       icon:icon
                                                       font:font
                                                  alligment:RAJAlligentTop];
}


+ (void)showNotificationWithMessage:(NSString*)message
                          textColor:(UIColor*)textColor
                    backgroundColor:(UIColor*)backgroundColor
{
    [RAJNotificationView showSuccessNotificationWithMessage:message
                                            backGroundColor:backgroundColor
                                                  textColor:textColor
                                                       icon:nil
                                                       font:nil
                                                  alligment:RAJAlligentTop];
}


+ (void)showSuccessNotificationWithMessage:(NSString*)message
                           backGroundColor:(UIColor*)bgColor
                                 textColor:(UIColor*)textColor
                                      icon:(UIImage*)icon
                                      font:(UIFont*)font
                                 alligment:(RAJNovificationVerticalAlligment)alligment;
{
    UIWindow* mainWindow = [[UIApplication sharedApplication]delegate].window;
    
    if (!font) {
        font = [UIFont boldSystemFontOfSize:14];
    }
    CGFloat notificationWidth = mainWindow.frame.size.width - kNotificationViewIndent;
    CGFloat maxHeight = mainWindow.frame.size.width-kNotificationViewIndent-[UINavigationBar appearance].frame.size.width;
    
    CGRect messageRect = [RAJNotificationView messageHeightForText:message
                                                                 font:font
                                                                width:(notificationWidth - (kNotificationLabelIndent*2))
                                                            maxHeight:maxHeight];
    
    CGFloat messageHeight = messageRect.size.height;
    CGFloat messageWidth = messageRect.size.width;
    NSLog(@"width: %f",messageWidth);
    CGFloat viewHeight = messageHeight + (kNotificationLabelIndent*2);
    
    CGFloat viewWidth = messageWidth + 2*kNotificationLabelIndent;
    if (icon) {
        viewHeight = messageHeight + kIconWidth + (kNotificationLabelIndent*3);
    }
    
    RAJNotificationView* notificationView = [[RAJNotificationView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    
    notificationView.backgroundColor = bgColor;
    notificationView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    notificationView.layer.shadowOpacity = 0.6;
    notificationView.layer.shadowOffset = CGSizeMake(0, 0);
    notificationView.layer.shadowRadius = 10;
    
    notificationView.messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    notificationView.messageLabel.numberOfLines = 0;
    notificationView.messageLabel.textColor = textColor;
    notificationView.messageLabel.font = font;
    [notificationView.messageLabel setFrame:CGRectMake(0, 0, notificationView.frame.size.width - 2*kNotificationLabelIndent, messageHeight)];
    notificationView.messageLabel.center = CGPointMake(notificationView.center.x, viewHeight - notificationView.messageLabel.frame.size.height/2 - kNotificationLabelIndent);
    notificationView.messageLabel.text = message;

    
    notificationView.iconView.image = icon;
    notificationView.iconView.center = CGPointMake(notificationView.center.x, kNotificationLabelIndent + kIconWidth/2);
    
    [[mainWindow rootViewController].view addSubview:notificationView];
    
    [notificationView configureAllignment:alligment];
    notificationView.alpha = 0;
    
    NSLog(@"frame\n x:%f, y:%f, width:%f, height:%f",notificationView.frame.origin.x, notificationView.frame.origin.y,notificationView.frame.size.width, notificationView.frame.size.height);
    
    __block typeof(notificationView) blockView = notificationView;
    [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        blockView.alpha = 1;
    } completion:^(BOOL finished) {
        notificationView.alpha = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kShowingTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 delay:0.1 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                blockView.alpha = 0;
            } completion:^(BOOL finished) {
                notificationView.alpha = 0;
                [blockView removeFromSuperview];
            }];
        });
    }];
}

- (void)configureAllignment:(RAJNovificationVerticalAlligment)allignment
{
    CGFloat navHeigth = 20;
    
    UIWindow* mainWindow = [[UIApplication sharedApplication]delegate].window;
    switch (allignment) {
        case RAJAlligentTop:
            if (mainWindow.rootViewController.navigationItem) {
                navHeigth = 20 + 44;
            }
            self.center = CGPointMake(mainWindow.center.x, navHeigth + kNotificationLabelIndent + self.frame.size.height/2);
            break;
        case RAJAlligentCenter:
            self.center = CGPointMake(mainWindow.center.x, mainWindow.center.y);
            break;
        case RAJAlligentBottom:
            navHeigth = 0;
            if (mainWindow.rootViewController.tabBarItem) {
                navHeigth = 44;
            }
            
            self.center = CGPointMake(mainWindow.center.x,mainWindow.frame.size.height - (navHeigth + kNotificationLabelIndent + self.frame.size.height/2));
            break;
        default:
            break;
    }
}

+ (CGRect)messageHeightForText:(NSString*)text
                           font:(UIFont*)font
                          width:(CGFloat)width
                      maxHeight:(CGFloat)maxHeight
{
    CGSize maximumLabelSize = CGSizeMake(width,maxHeight);
    
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                forKey:NSFontAttributeName];
    NSAttributedString *atrString = [[NSAttributedString alloc]initWithString:text attributes:attrsDictionary];
    
    CGRect stringRect = [atrString boundingRectWithSize:maximumLabelSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
    
    return stringRect;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 4;
    }
    return self;
}

- (UIImageView*)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kIconWidth, kIconWidth)];
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 2*kNotificationLabelIndent, kNotificationViewIndent)];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

@end
