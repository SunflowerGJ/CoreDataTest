//
//  HUDTool.m
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/11.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import "HUDTool.h"

#import "SVProgressHUD.h"

@implementation HUDTool

+(void)showLoadingMessage:(NSString *)message{
    if (!message)  {
        message = @"请稍后...";
    }
    [SVProgressHUD showInfoWithStatus:message];
}
+(void)showSuccessAlertMessage:(NSString *)message{
    [SVProgressHUD showSuccessWithStatus:message];
}
+(void)showFailureAlertmessage:(NSString *)message{
    [SVProgressHUD showErrorWithStatus:message];
}
+(void)dismiss{
    [SVProgressHUD dismiss];
}
@end
