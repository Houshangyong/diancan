//
//  MTGuideViewController.m
//  MTGJ
//
//  Created by Apple on 15/6/1.
//  Copyright (c) 2015年 MallTang. All rights reserved.
//

#import "MTGuideViewController.h"
#import "HNCFCommmon.h"
#import "AppDelegate.h"

@interface MTGuideViewController ()<UIScrollViewDelegate>
@property (nonatomic ,retain)UIPageControl *pageControl;
@property (nonatomic ,retain)UIScrollView *scrollView;

@end

@implementation MTGuideViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     _scrollView.contentOffset = CGPointMake(0, 0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];   //加载新用户指导页面

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initGuide
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,self.view.height)];
    [_scrollView setContentSize:CGSizeMake(self.view.width *3,self.view.height)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setPagingEnabled:YES];  //视图整页显示
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width,self.view.height)];
    
    [_scrollView addSubview:imageview];
    
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width,self.view.height)];
    
    
    [_scrollView addSubview:imageview1];
    
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.width*2, 0, self.view.width,self.view.height)];
    imageview2.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应

    [_scrollView addSubview:imageview2];
    
    
        [imageview setImage:[UIImage imageNamed:@"113456.png"]];
        [imageview1 setImage:[UIImage imageNamed:@"113456.png"]];
        [imageview2 setImage:[UIImage imageNamed:@"113456.png"]];
    
        
    
       UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    
    [button setShowsTouchWhenHighlighted:YES];
    
   	[button setFrame:self.view.bounds];
    
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [imageview2 addSubview:button];
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.view.width-80)/2, self.view.frame.size.height - 40, 80, 6)];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl = pageControl;
    
    
    [self.view addSubview:_scrollView];
    [self.view addSubview:self.pageControl];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView1
{
    
    CGFloat offsetX = scrollView1.contentOffset.x;
    //    NSLog(@"%f",offsetX);
    int x = (int)(((offsetX-self.view.width+160) / self.view.width) + 4) % 3;
    //    NSLog(@"XXXXX::%d",x);
    
    self.pageControl.currentPage = x % 3;
    if (offsetX+[UIScreen mainScreen].bounds.size.width >[UIScreen mainScreen].bounds.size.width*3) {
        HNCF_APP_DELEGATE.window.rootViewController =  HNCF_APP_DELEGATE.tabBarController;

    }

}

- (void)firstpressed
{


    HNCF_APP_DELEGATE.window.rootViewController =  HNCF_APP_DELEGATE.tabBarController;
   
}


@end
