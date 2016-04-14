//
//  AddMemberViewController.h
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/14.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Family.h"
#import "Member.h"

@interface AddMemberViewController : UIViewController

@property (nonatomic,strong) Family *objFamily;
@property (nonatomic,strong) Member *objMember;

@end
