//
//  Member.h
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Family.h"

NS_ASSUME_NONNULL_BEGIN


@interface Member : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(void)addNewMemberToFamily:(Family *)family WithName:(NSString *)name age:(NSString *)age phone:(NSString *)phone success:(void (^)())success failure:(void(^)(NSError *error))failure;

/** 返回以NSManageObject类型的对象集合 */
+(NSArray *)fetchMemberListsWithFamily:(NSString *)familyName;

+(void)updateMember:(Member *)member WithName:(NSString *)name age:(NSString *)age phone:(NSString *)phone success:(void (^)())success failure:(void(^)(NSError *error))failure;

+(void)deleteMember:(Member *)member FromFamily:(Family *)family success:(void (^)())success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

#import "Member+CoreDataProperties.h"
