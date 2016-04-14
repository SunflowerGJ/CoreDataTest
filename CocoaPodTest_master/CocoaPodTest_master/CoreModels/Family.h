//
//  Family.h
//  CocoaPodTest_master
//
//  Created by GJ on 16/4/13.
//  Copyright © 2016年 GJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Member;

NS_ASSUME_NONNULL_BEGIN

@interface Family : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(void)addNewFamilyWithName:(NSString *)name address:(NSString *)address success:(void (^)())success failure:(void(^)(NSError *error))failure;

+(void)deleteFamily:(Family *)family success:(void (^)())success failure:(void(^)(NSError *error))failure;

/** 返回以NSManageObject类型的对象集合 */
+(NSArray *)fetchFamilyLists;

@end

NS_ASSUME_NONNULL_END

#import "Family+CoreDataProperties.h"
