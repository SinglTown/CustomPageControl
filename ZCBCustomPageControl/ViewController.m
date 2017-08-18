//
//  ViewController.m
//  ZCBCustomPageControl
//
//  Created by 赵传保 on 2017/8/18.
//  Copyright © 2017年 赵传保. All rights reserved.
//

#import "ViewController.h"
#import "AnyeCustomPageControl.h"
@interface ViewController ()
@property (nonatomic ,assign) NSInteger index;
@property (nonatomic,strong)AnyeCustomPageControl *myPageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myPageControl = [[AnyeCustomPageControl alloc] initWithFrame:CGRectMake(100, 320, 50, 5)];
    self.myPageControl.center = CGPointMake(self.view.frame.size.width/2, 320);
    self.myPageControl.selectedColor = [UIColor purpleColor];
    self.myPageControl.normalColor = [UIColor blackColor];
    self.myPageControl.selectedPageWidth = 30;
    
    self.myPageControl.selectedIndex = 0;
    self.myPageControl.pageCount = 3;
    self.index = self.myPageControl.selectedIndex;
    
    [self.view addSubview:self.myPageControl];
}
- (IBAction)lastPageAction:(id)sender {
    
    self.index--;
    [self.myPageControl setSelectedIndex:self.index];
}
- (IBAction)nextPageAction:(id)sender {
    self.index++;
    [self.myPageControl setSelectedIndex:self.index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
