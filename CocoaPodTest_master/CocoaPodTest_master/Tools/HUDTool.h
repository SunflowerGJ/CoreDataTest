//
//  HUDTool.h
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/11.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface HUDTool : MBProgressHUD

+(void)showLoadingMessage:(NSString *)message;
+(void)showSuccessAlertMessage:(NSString *)message;
+(void)showFailureAlertmessage:(NSString *)message;

+(void)dismiss;

@end
