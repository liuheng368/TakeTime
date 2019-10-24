//
//  HeFengConfigModel.h
//  HeWeather_Plugin
//
//  Created by he on 2019/5/13.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//
#define HeFengColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 类型描述

 - HeFengConfigModelTypeLocation:所在城市名称
 - HeFengConfigModelTypeTemp: 温度
 - HeFengConfigModelTypeWeatherState: 天气状况
 - HeFengConfigModelTypeWeatherStateIcon: 天气状况图标
 - HeFengConfigModelTypeWindSC: 风力
 - HeFengConfigModelTypeWindDirIcon: 风向图标
 - HeFengConfigModelTypeAlarmIcon: 灾害预警图标
 - HeFengConfigModelTypeAlarm: 灾害预警
 - HeFengConfigModelTypePcpnIcon: 分钟降雨图标
 - HeFengConfigModelTypePcpn: 分钟降雨
 - HeFengConfigModelTypeAqiTitle: 空气质量文字AQI
 - HeFengConfigModelTypeQlty: 空气质量等级
 - HeFengConfigModelTypeAqi: 空气质量
 */
typedef NS_ENUM(NSInteger, HeFengConfigModelType) {
    HeFengConfigModelTypeLocation,
    HeFengConfigModelTypeTemp,
    HeFengConfigModelTypeWeatherState,
    HeFengConfigModelTypeWeatherStateIcon,
    HeFengConfigModelTypeWindSC,
    HeFengConfigModelTypeWindDirIcon,
    HeFengConfigModelTypeAlarmIcon,
    HeFengConfigModelTypeAlarm,
    HeFengConfigModelTypePcpnIcon,
    HeFengConfigModelTypePcpn,
    HeFengConfigModelTypeAqiTitle,
    HeFengConfigModelTypeQlty,
    HeFengConfigModelTypeAqi,
};
@interface HeFengConfigModel : NSObject

/**
 字体大小，设置范围6-36 默认12
 */
@property (nonatomic,strong) UIFont *textFont;

/**
 文字对齐方式 默认 NSTextAlignmentCenter
 */
@property (nonatomic,assign) NSTextAlignment textAlignment;

/**
 字体颜色 默认 4a4a4a
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 空气质量颜色数组只对 HeFengConfigModelTypeQlty HeFengConfigModelTypeAqi类型有效 数组按顺序存放颜色，对应的顺序为优、良、轻度、中度、重度、严重， 六个等级都要设置才有效否则使用默认
 */
@property (nonatomic,strong) NSArray *airTextColorArray;

/**
 预警文字颜色数组只对 HeFengConfigModelTypeAlarm类型有效 数组按顺序存放颜色，对应的顺序为白色、蓝色、黄色、橙色、红色， 五个等级都要设置才有效否则使用默认
 */
@property (nonatomic,strong) NSArray *alarmTextColorArray;

/**
 图片大小，默认12*12，可调范围6*6-32*32，如12*12传入12即可
 */
@property (nonatomic,assign) CGFloat iconSize;

/**
 1.自定义天气状况图标名：图片命名规则为白天xxx_code_d，夜晚xxx_code_n 其中code参看天气状况代码 传入xxx前缀即可
 2.自定义湿度图片:直接使用图片名
 3.自定义风向图片:图片命名规范为xxx_wind_nodirection(无持续风向图标)，xxx_wind_rotate(旋转风图标)，xxx_wind_normal(普通风向图标，图片指向北方即可，内部做了旋转处理)，传入前缀xxx即可
 */
@property (nonatomic,strong) NSString *iconImageTitle;

/**
 控件type
 */
@property (nonatomic,assign) HeFengConfigModelType type;

/**
 子控件距离父视图的内边距 遵从线性布局 比如横向布局第二个控件距离第一个控件的间距遵从第二个间距的左边距第一个控件的右边距无效。
 */
@property (nonatomic,assign) UIEdgeInsets padding;


@end

NS_ASSUME_NONNULL_END
