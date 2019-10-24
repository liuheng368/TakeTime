//
//  HeFengPluginView.h
//  HeWeather_Plugin
//
//  Created by he on 2019/5/13.
//  Copyright © 2019 HeFengTianQi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeFengPluginViewLoadCompleted)(CGSize size);

@class HeFengConfigModel;


/**
 浮窗布局样式
 
 - HeFengPluginViewTypeHorizontal: 横向水平
 - HeFengPluginViewTypeLeftLarge: 横向三块布局 单独布局在左
 - HeFengPluginViewTypeRightLarge: 横向三块布局 单独布局在右
 - HeFengPluginViewTypeVertical: 垂直布局
 */
typedef NS_ENUM(NSInteger, HeFengPluginViewType) {
    HeFengPluginViewTypeHorizontal,
    HeFengPluginViewTypeLeftLarge,
    HeFengPluginViewTypeRightLarge,
    HeFengPluginViewTypeVertical,
};

/**
 插件内容水平方向显示对齐方式
 
 - HeFengContentViewAlignmentCenter: 内容居中（默认）
 - HeFengContentViewAlignmentTop: 内容居上
 - HeFengContentViewAlignmentLeft: 内容居左
 - HeFengContentViewAlignmentDown: 内容居下
 - HeFengContentViewAlignmentRight: 内容居右
 
 */
typedef NS_ENUM(NSInteger, HeFengContentViewAlignment) {
    HeFengContentViewAlignmentCenter,
    HeFengContentViewAlignmentTop,
    HeFengContentViewAlignmentLeft,
    HeFengContentViewAlignmentDown,
    HeFengContentViewAlignmentRight
};
/**
 拖拽方向
 
 - HeFengPluginViewDragDirectionAny: 任意方向 （默认）
 - HeFengPluginViewDragDirectionHorizontal: 水平方向
 - HeFengPluginViewDragDirectionVertical: 垂直方向
 */
typedef NS_ENUM(NSInteger, HeFengPluginViewDragDirection) {
    HeFengPluginViewDragDirectionAny,
    HeFengPluginViewDragDirectionHorizontal,
    HeFengPluginViewDragDirectionVertical,
};
/**
 主题样式：
 - HeFengPluginViewIconTypeLight: 随天气变化，使用背景图片,设置背景色无效
 - HeFengPluginViewIconTypeLight: 亮色 使用默认背景颜色
 - HeFengPluginViewIconTypeDark: 暗色 使用默认背景颜色
 */
typedef NS_ENUM(NSInteger, HeFengPluginViewThemeType) {
    HeFengPluginViewThemeTypeAuto=1,
    HeFengPluginViewThemeTypeLight,
    HeFengPluginViewThemeTypeDark
};

@interface HeFengPluginView : UIView

/**
 location 城市或地区，可输入以下值：
 1. 城市ID：城市列表
 2. 经纬度格式：经度,纬度（经度在前纬度在后，英文,分隔，十进制格式，北纬东经为正，南纬西经为负
 3. 可为空，系统自动获取当前设备所在经纬度，然后将获取到的经纬度作为location参数调用传location的接口
 4. 修改location会重新刷新数据
 */
@property (nonatomic,copy) NSString *location;

#pragma mark 视图设置

/**
 1.此数组用于配置插件内部视图属性如字体，字色等，数组内部可装HeFengConfigModel，也可以嵌套HeFengConfigModel数组用于多个子布局视图的情况。数组添加的顺序决定了控件摆放的顺序。
 2.当视图类型为HeFengPluginViewTypeLeftLarge时，configArray[0]内元素会被放在左边大布局上, configArray[1]内元素会被放在右边上部分布局上, configArray[2]内元素会被放在右边下部分布局上
 3.当视图类型为HeFengPluginViewTypeRightLarge时，configArray[0]内元素会被放在右边大布局上, configArray[1]内元素会被放在左边上部分布局上, configArray[2]内元素会被放在左边下部分布局上
 */
@property (nonatomic,strong) NSArray *configArray;

/**
 设置插件内容对齐方式
 */
@property (nonatomic,assign) HeFengContentViewAlignment contentViewAlignmen;

/**
 设置主题样式（默认跟随天气变化）
 */
@property (nonatomic,assign) HeFengPluginViewThemeType themType;

/**
 HeFengPluginView的内边距
 */
@property (nonatomic,assign) UIEdgeInsets padding;

/**
 设置背景颜色 当themType的值不为HeFengPluginViewThemeTypeAuto时设置有效
 */
@property (nonatomic,strong) UIColor *backgroundColor;

/**
 自定义背景图片：当themType的值为HeFengPluginViewThemeTypeAuto时设置有效,图片命名规则为白天xxx_code_d，夜晚xxx_code_n 其中code参看天气状况代码 传入xxx前缀即可
 */
@property (nonatomic,strong) NSString *backgroundImageTitle;

/**
 边框颜色 默认值 #F5F5F5
 */
@property (nonatomic,strong) UIColor *borderColor;

/**
 边框宽度 默认值 2
 */
@property (nonatomic,assign) CGFloat borderWidth;
/**
 圆角 默认值 4
 */
@property (nonatomic,assign) CGFloat cornerRadius;

/**
 是否显示圆角 默认开启 YES
 */
@property (nonatomic,assign) BOOL isShowConer;

/**
 是否显示边框 默认开启 YES
 */
@property (nonatomic,assign) BOOL isShowBorder;

#pragma mark 详情设置
/**
 导航条背景颜色
 */
@property (nonatomic,strong) UIColor *navigationBarBackgroundColor;

/**
 导航条返回图片
 */
@property (nonatomic,strong) UIImage *navBarBackImage;
/**
 导航条关闭图片
 */
@property (nonatomic,strong) UIImage *navBarCloseImage;
/**
 进度条颜色
 */
@property (nonatomic,strong) UIColor *progressColor;


#pragma mark 拖拽设置
/**
 是不是能拖曳，默认为NO
 YES，能拖曳
 NO，不能拖曳
 */
@property (nonatomic,assign) BOOL dragEnable;

/**
 是不是总保持在父视图边界，默认为NO,有黏贴边界效果
 isKeepBounds = YES，它将自动黏贴边界，而且是最近的边界
 isKeepBounds = NO， 它将不会黏贴在边界，它是free(自由)状态，跟随手指到任意位置，但是也不可以拖出给定的范围frame
 */
@property (nonatomic,assign) BOOL isKeepBounds;

/**
 活动范围，默认为父视图的frame范围内（因为拖出父视图后无法点击，也没意义）
 如果设置了，则会在给定的范围内活动
 如果没设置，则会在父视图范围内活动
 注意：设置的frame不要大于父视图范围
 注意：设置的frame为0，0，0，0表示活动的范围为默认的父视图frame，如果想要不能活动，请设置dragEnable这个属性为NO
 */
@property (nonatomic,assign) CGRect freeRect;

/**
 拖曳的方向，默认为any，任意方向
 */
@property (nonatomic,assign) HeFengPluginViewDragDirection dragDirection;

/**
 block返回加载完数据的父视图size
 */
@property (nonatomic,copy) HeFengPluginViewLoadCompleted loadCompleted;


#pragma mark 初始化方法

/**
 @param frame 视图frame
 @param type 浮窗样式枚举
 @param userKey 用户key 必填
 @param location 城市或地区，可输入以下值：
 1. 城市ID：城市列表
 2. 经纬度格式：经度,纬度（经度在前纬度在后，英文,分隔，十进制格式，北纬东经为正，南纬西经为负
 3. 城市名称，支持中英文和汉语拼音
 4. 城市名称，上级城市 或 省 或 国家，英文,分隔，此方式可以在重名的情况下只获取想要的地区的天气数据，例如 西安,陕西
 5. IP
 6. 根据请求自动判断，根据用户的请求获取IP，通过 IP 定位并获取城市数据
 7. 可为空，系统自动获取当前设备所在经纬度，然后将获取到的经纬度作为location参数调用传location的接口
 @return HeFengPluginView 插件视图
 */
+(instancetype)initWithFrame:(CGRect)frame ViewType:(HeFengPluginViewType)type UserKey:(NSString *)userKey Location:(NSString *)location;

/**
 @param frame 视图frame
 @param type 浮窗样式枚举
 @param userKey 用户key 必填
 @param location 城市或地区，可输入以下值：
 1. 城市ID：城市列表
 2. 经纬度格式：经度,纬度（经度在前纬度在后，英文,分隔，十进制格式，北纬东经为正，南纬西经为负
 3. 可为空，系统自动获取当前设备所在经纬度，然后将获取到的经纬度作为location参数调用传location的接口
 @return HeFengPluginView 插件视图
 */
-(instancetype)initWithFrame:(CGRect)frame ViewType:(HeFengPluginViewType)type UserKey:(NSString *)userKey Location:(NSString *)location;

@end
