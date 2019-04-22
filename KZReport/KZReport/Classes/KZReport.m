//
//  KZReportLib.m
//  Report_lib
//
//  Created by renzhaofeng on 2019/3/13.
//

#import "KZReport.h"
#import <Bugly/Bugly.h>


@implementation KZReport

+ (void)startWithAppId:(NSString * BLY_NULLABLE)appId
{
    [Bugly startWithAppId:appId];
}

+ (void)startWithAppId:(NSString * BLY_NULLABLE)appId
                config:(BuglyConfig * BLY_NULLABLE)config
{
    [Bugly startWithAppId:appId config:config];
}

+ (void)reportExceptionWithType:(KZReportExceptionType)type navigationController:(UINavigationController * BLY_NULLABLE)navigationController exceptionData:(id BLY_NULLABLE)exceptionData extraInfo:(NSDictionary * BLY_NULLABLE)extraInfo reason:(NSString * BLY_NULLABLE)reason
{
    NSString *exceptionName = [self.class getExceptionNameByType:type];
    
    NSMutableDictionary *extInfo = [NSMutableDictionary dictionary];
    
    if ([extraInfo isKindOfClass:[NSDictionary class]]) {
        [extInfo addEntriesFromDictionary:extraInfo];
    }

    if (exceptionData) {
        [extInfo setObject:exceptionData forKey:@"exceptionData"];
    }
    
    if ([navigationController isKindOfClass:[navigationController class]]) {
        [extInfo setObject:navigationController.viewControllers forKey:@"viewControllers"];
    }
    
    if ([reason isKindOfClass:[NSString class]]) {
        [extInfo setObject:reason forKey:@"exceptionReason"];
    }
    
    if ([exceptionName isKindOfClass:[NSString class]]) {
        [extInfo setObject:exceptionName forKey:@"exceptionName"];
    }
    NSException *exception = [NSException exceptionWithName:exceptionName reason:reason userInfo:extInfo];

   [Bugly reportException:exception];

}


+ (NSString *)getExceptionNameByType:(KZReportExceptionType)type
{
    NSString *retureText = @"";
    switch (type) {
        case KZReportExceptionTypeUnKnown:
            retureText = @"未知错误";
            break;
        case KZReportExceptionTypeOutRange:
            retureText = @"数组越界";
            break;
        case KZReportExceptionTypeUnRecognizedSelector:
            retureText = @"未找到实现方法";
            break;
        case KZReportExceptionTypeServerSideDataError:
            retureText = @"接口数据类型异常";
            break;
        case KZReportExceptionTypeNetError:
            retureText = @"请求失败";
            break;
        case KZReportExceptionTypeCustom:
            retureText = @"自定义类型";
            break;
            
        default:
            break;
    }
    
    return retureText;
}

@end
