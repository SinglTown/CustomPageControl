//
//  AnyeCustomPageControl.h
//  anye
//
//  Created by 赵传保 on 2017/8/18.
//  Copyright © 2017年 暗夜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnyeCustomPageControl : UIView

//数量
@property (nonatomic,assign)NSInteger pageCount;

//默认选中的index
@property (nonatomic,assign)NSInteger selectedIndex;

//当前的选中的颜色
@property (nonatomic,strong)UIColor *selectedColor;

//其他颜色
@property (nonatomic,strong)UIColor *normalColor;


//选中的page的宽度
@property (nonatomic,assign)CGFloat selectedPageWidth;



@end
