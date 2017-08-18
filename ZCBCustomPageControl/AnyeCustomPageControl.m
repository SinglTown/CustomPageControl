//
//  AnyeCustomPageControl.m
//  anye
//
//  Created by 赵传保 on 2017/8/18.
//  Copyright © 2017年 暗夜. All rights reserved.
//

#import "AnyeCustomPageControl.h"

#define PageControlDefaultSelectedWidth 30

@interface AnyeCustomPageControl ()

@property (nonatomic,strong)NSMutableArray *pageImageViewArr;

@property (nonatomic,strong)UIImageView *currentPage;

@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,assign)CGFloat pageSpace;
@end

@implementation AnyeCustomPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}
-(void)allViews
{
    self.pageImageViewArr = [[NSMutableArray alloc] init];
    self.selectedPageWidth = PageControlDefaultSelectedWidth;
    self.pageSpace = (self.frame.size.width-(self.pageCount-1)*self.frame.size.height-self.selectedPageWidth)/(self.pageCount-1);
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.normalColor = [UIColor orangeColor];
    self.selectedColor = [UIColor orangeColor];
    
    self.currentIndex = 0;
    self.selectedIndex = 0;
}
-(void)setPageCount:(NSInteger)pageCount
{
    _pageCount = pageCount;
    
    self.pageSpace = (self.frame.size.width-(self.pageCount-1)*self.frame.size.height-self.selectedPageWidth)/(self.pageCount-1);
    
    [self setPagesOfControl];
    
}
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    
    if (selectedIndex == self.currentIndex || selectedIndex < 0 || selectedIndex >= self.pageCount) {
        return;
    }
    
    NSLog(@"移动的下标---%ld",selectedIndex);
    UIImageView * currentDot = self.currentPage;
    if (self.pageImageViewArr.count == 0) {
        [self setPagesOfControl];
    }
    if (selectedIndex > self.currentIndex) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentDot.center;
            //计算center
            CGFloat currentCenterX = self.frame.size.height*selectedIndex+self.pageSpace*selectedIndex+self.selectedPageWidth/2;
            currentDot.center = CGPointMake(currentCenterX, self.frame.size.height/2);
            for (NSInteger i = self.currentIndex; i < selectedIndex; i ++) {
                UIImageView * bitPage = [self.pageImageViewArr objectAtIndex:i];
                bitPage.center = CGPointMake(bitPage.center.x - self.frame.size.height/2 - self.pageSpace-self.selectedPageWidth + self.frame.size.height/2, currentPoint.y);
            }
        }];
        
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint currentPoint = currentDot.center;
            //计算center
            NSInteger useIndex = self.pageCount-selectedIndex-1;
            CGFloat currentCenterX = self.frame.size.width-(self.frame.size.height*useIndex+self.pageSpace*useIndex+self.selectedPageWidth/2);
            currentDot.center = CGPointMake(currentCenterX, self.frame.size.height/2);
            for (NSInteger i = selectedIndex; i < self.currentIndex; i ++) {
                UIImageView * bitPage = [self.pageImageViewArr objectAtIndex:i];
                bitPage.center = CGPointMake(bitPage.center.x + self.frame.size.height/2 + self.pageSpace + self.selectedPageWidth - self.frame.size.height/2, currentPoint.y);
            }
        }];
    }
    self.currentIndex = selectedIndex;
    
}
-(void)setSelectedPageWidth:(CGFloat)selectedPageWidth
{
    _selectedPageWidth = selectedPageWidth;
    
    self.currentPage.frame = CGRectMake(0, 0, self.selectedPageWidth, self.frame.size.height);
    
    self.pageSpace = (self.frame.size.width-(self.pageCount-1)*self.frame.size.height-self.selectedPageWidth)/(self.pageCount-1);
    if (self.pageImageViewArr.count == 0) {
        [self setPagesOfControl];
        return;
    }
    for (UIImageView *page in self.pageImageViewArr) {
        CGFloat X = self.selectedPageWidth + self.pageSpace + (self.pageSpace+self.frame.size.height)*([self.pageImageViewArr indexOfObject:page]);
        page.frame = CGRectMake(X, 0, self.frame.size.height,self.frame.size.height);
    }
    
}
-(void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    
    self.currentPage.backgroundColor = selectedColor;
}
-(void)setNormalColor:(UIColor *)normalColor
{
    _normalColor = normalColor;
    
    if (self.pageImageViewArr.count == 0) {
        [self setPagesOfControl];
        return;
    }
    for (UIImageView *page in self.pageImageViewArr) {
        page.backgroundColor = normalColor;
    }
}
-(UIImageView *)currentPage
{
    if (!_currentPage) {
        _currentPage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.selectedPageWidth, self.frame.size.height)];
        _currentPage.backgroundColor = self.selectedColor;
        _currentPage.clipsToBounds = YES;
        _currentPage.layer.cornerRadius = self.frame.size.height/2;
    }
    return _currentPage;
}
//创建page
-(void)setPagesOfControl
{
    for (UIImageView *page in self.pageImageViewArr) {
        [page removeFromSuperview];
    }
    [self.pageImageViewArr removeAllObjects];
    
    for (int i = 0; i < self.pageCount-1; i++) {
        CGFloat X = self.selectedPageWidth + self.pageSpace + (self.pageSpace+self.frame.size.height)*i;;
        UIImageView * page = [[UIImageView alloc]initWithFrame:CGRectMake(X, 0, self.frame.size.height,self.frame.size.height)];
        page.tag = i;
        page.layer.cornerRadius = self.frame.size.height/2;
        page.layer.masksToBounds = YES;
        page.backgroundColor = self.normalColor;
        [self addSubview:page];
        [self.pageImageViewArr addObject:page];
    }
    
    [self addSubview:self.currentPage];
}
@end
