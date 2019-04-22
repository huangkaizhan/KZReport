//
//  KZReportLib.h
//  Report_lib
//
//  Created by renzhaofeng on 2019/3/13.
//

#import <Foundation/Foundation.h>
#import <Bugly/Bugly.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KZReportExceptionType) {
    KZReportExceptionTypeUnKnown = 0, //未知错误
    KZReportExceptionTypeOutRange = 1 , //数组越界
    KZReportExceptionTypeUnRecognizedSelector = 2 , //找不到方法实现
    KZReportExceptionTypeServerSideDataError = 3 ,//接口数据出错
    KZReportExceptionTypeNetError = 4 , //网络不通
    KZReportExceptionTypeCustom = 5 //自定义
};

@interface KZReport : NSObject

/**
 *  初始化Bugly,使用默认BuglyConfig
 *
 *  @param appId 注册Bugly分配的应用唯一标识
 */
+ (void)startWithAppId:(NSString * BLY_NULLABLE)appId;

/**
 *  使用指定配置初始化Bugly
 *
 *  @param appId 注册Bugly分配的应用唯一标识
 *  @param config 传入配置的 BuglyConfig
 */
+ (void)startWithAppId:(NSString * BLY_NULLABLE)appId
                config:(BuglyConfig * BLY_NULLABLE)config;

/**
 *  向Bugly上报
 *
 *  @param type 自定义异常类型
 *  @param navigationController 当前的导航控制器
 *  @param exceptionData 异常的模型（如数组越界传数组）
 *  @param reason 具体原因
 

 */
+ (void)reportExceptionWithType:(KZReportExceptionType)type navigationController:(UINavigationController * BLY_NULLABLE)navigationController exceptionData:(id BLY_NULLABLE)exceptionData extraInfo:(NSDictionary * BLY_NULLABLE)extraInfo reason:(NSString * BLY_NULLABLE)reason;


@end

NS_ASSUME_NONNULL_END
