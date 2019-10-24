//
//  HeWeather_Plugin.h
//  HeWeather_Plugin
//
//  Created by he on 2019/5/13.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for HeWeather_Plugin.
FOUNDATION_EXPORT double HeWeather_PluginVersionNumber;

//! Project version string for HeWeather_Plugin.
FOUNDATION_EXPORT const unsigned char HeWeather_PluginVersionString[];


/* 当前版本 2019-06-06 1.0 */

/*
 1.请将frameWork加入项目中，导入头文件#import <HeWeather_Plugin/HeWeather_Plugin.h>
 */

/*
 2.本项目依赖于 'SDWebImage' 'Masonry'请确保您的项目中已经安装这两个类库
 */

/*
 3.sdk需要开启定位权限，请在工程plist.info文件中添加NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationWhenInUseUsageDescription
 */

/*
 4.请在info.plist文件添加NSAppTransportSecurity ->Allow Arbitrary Loads元素，同时设为 YES
 */
#import <HeWeather_Plugin/HeFengPluginView.h>

#import "HeWeather_Plugin/HeFengConfigModel.h"


