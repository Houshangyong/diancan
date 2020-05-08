//
//  HNCFHDetailViewController.m
//  HNCF
//
//  Created by Apple on 15/12/29.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFHDetailViewController.h"
#import "HNCFCommmon.h"

@interface HNCFHDetailViewController ()<HNCFNaViewDelegate,HNCFHeadBrandViewDelegate,UITableViewDelegate,UITableViewDataSource,PullTableViewDelegate,HNCFHomeDetailDelegate>
@property (nonatomic , strong) HNCFNaView *naView;
@property (nonatomic , strong) HNCFHeadBrandView *headBrandView;
@property (nonatomic , strong) UIButton *backButton;
@property (nonatomic , strong) HNCFHomeDetail *MiddleView;
@property (nonatomic ) BOOL isCollection;
@property (nonatomic , strong) UIView *headView;
@property (nonatomic , strong) PullTableView *mainTableView;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic , strong) NSMutableArray *conmentList;
@property (nonatomic , strong) NSMutableArray *mutaArray;

@property (nonatomic , strong) UIView *footView;
@property (nonatomic , strong) UILabel *footLabel;
@property (nonatomic , strong) UIButton *footButton;
@property (nonatomic , strong) UIButton *shopButton;
@property (nonatomic , strong) UILabel *countLabel;

@end

@implementation HNCFHDetailViewController

- (NSMutableArray *)conmentList
{
    if (!_conmentList) {
        _conmentList = [NSMutableArray arrayWithCapacity:0];
    }
    return _conmentList;
}
- (PullTableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[PullTableView alloc]initWithFrame:CGRectMake(0, 0, HNCFWidth, HNCFHeight-49-64) style:UITableViewStylePlain];
//        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.pullDelegate = self;
        _mainTableView.tableHeaderView = self.headView;
        _mainTableView.rowHeight = 70;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}
- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, self.mainTableView.maxY, HNCFWidth, 49)];
        _footView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        _footView.layer.borderWidth = 0.2;
    }
    
    return _footView;
}
- (UILabel *)footLabel
{
    if (!_footLabel) {
        _footLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 49)];
        _footLabel.textColor = [UIColor redColor];
    }
    
    return _footLabel;
}
- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 20, 20)];
        _countLabel.backgroundColor = [UIColor redColor];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont systemFontOfSize:12.0];
        _countLabel.hidden = YES;
        _countLabel.layer.cornerRadius = 10;
        _countLabel.layer.masksToBounds = YES;
    }
    
    return _countLabel;
}
- (UIButton *)footButton
{
    if (!_footButton) {
        _footButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _footButton.frame = CGRectMake((HNCFWidth-120)/2, 5, 120, 40);
        [_footButton setTitle:@"＋购物车" forState:UIControlStateNormal];
        _footButton.backgroundColor = [UIColor redColor];
        _footButton.layer.cornerRadius = 5;
        [_footButton bk_addEventHandler:^(id sender) {
            [self footButtonSlect];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _footButton;
}
- (UIButton *)shopButton
{
    if (!_shopButton) {
        _shopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopButton.frame = CGRectMake(self.footView.width-50, 5, 40, 40);
        [_shopButton setImage:[UIImage imageNamed:@"bianlidian"] forState:UIControlStateNormal];
  
        [_shopButton bk_addEventHandler:^(id sender) {
            [self shopButtonSlect];
        } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shopButton;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HNCF_APP_DELEGATE.tabBarController setTabBarHidden:YES];
    //    self.navigationController.navigationBar.hidden = YES;
    self.mutaArray = [[NSMutableArray alloc]init];
    if (self.bageIndex ==0) {
        self.countLabel.hidden = YES;
    }else{
        self.countLabel.hidden = NO;
        self.countLabel.text = [NSString stringWithFormat:@"%ld",self.bageIndex];
 
    }

      self.pageIndex = 1;
    if ([[NSString stringWithFormat:@"%@",[self.model objectForKey:@"sl_status"]] isEqualToString:@"N"]) {
        self.isCollection = YES;
        [self.naView setHomeBannerData:@"菜单详情" locationImage:YES rightButton:NO leftButton:NO rightImage:[UIImage imageNamed:@"ic_collect_on"]];
        
    }else{
        self.isCollection = NO;
        [self.naView setHomeBannerData:@"菜单详情" locationImage:YES rightButton:NO leftButton:NO rightImage:[UIImage imageNamed:@"ic_collect"]];
        
    }
    [MJProgressHUD showHUDWithText1:@"加载中.."];
    [self CommentRequest];
    
}
- (void)CommentRequest
{
    [HNCFRequestManager fetchShopcommentL:@{@"sd_shopid":[self.model objectForKey:@"id"],@"page":[NSString stringWithFormat:@"%ld",self.pageIndex]} success:^(id result) {
        NSInteger code = [[result objectForKey:@"code"]integerValue];
        if (code ==0) {
            [MJProgressHUD hide1];
            NSArray *orderList = [result objectForKey:@"result"];
            [self.mutaArray addObjectsFromArray:orderList];
            if (self.pageIndex ==1) {
                if ([[result objectForKey:@"result"] count]==0) {
                    [MJProgressHUD showHUDWithText:@"没有数据" duration:1.0];
                    
                }else{
                    self.conmentList = [result objectForKey:@"result"];
                    [self.MiddleView HNCFHomeDetailVIew1:self.model comentCount:self.conmentList];

                }
            }
            else{
                if ([[result objectForKey:@"result"] count]==0) {
                    
                    [MJProgressHUD showHUDWithText:@"已经是最后一页" duration:1.0];
                    
                }else{
                    
                    self.conmentList = self.mutaArray;
                          [self.MiddleView HNCFHomeDetailVIew1:self.model comentCount:self.conmentList];
                }
                
            }
            [self.mainTableView reloadData];
            
        }else{
            [MJProgressHUD hide1];
            [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HNCFWidth, HNCFHeight)];
        
    }
    return _headView;
}
- (HNCFNaView *)naView
{
    if (!_naView) {
        _naView = [[HNCFNaView alloc]initWithFrame:CGRectMake(0, 20, HNCFWidth, 44)];
        _naView.delegate = self;
    }
    return _naView;
}
- (HNCFHeadBrandView *)headBrandView
{
    if (!_headBrandView) {
        _headBrandView = [[HNCFHeadBrandView alloc]initWithFrame:CGRectMake(0, 0, HNCFWidth, HNCFWidth/2)];
        _headBrandView.delegate = self;
        _headBrandView.backgroundColor = [UIColor clearColor];
    }
    return _headBrandView;
}
- (HNCFHomeDetail *)MiddleView
{
    if (!_MiddleView) {
        _MiddleView = [[HNCFHomeDetail alloc]initWithFrame:CGRectMake(0, self.headBrandView.maxY, HNCFWidth, HNCFWidth)];
        _MiddleView.backgroundColor = [UIColor clearColor];
        _MiddleView.delegate = self;
    }
    return _MiddleView;
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.bageIndex = 0;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.naView];
    
    [self.headBrandView setHomeBannerData:@[@{@"content":[NSString stringWithFormat:@"%@%@",HNCF_IMAGE_URL,[self.model objectForKey:@"sl_thumb"]]}]];
    //    NSLog(@"%@",[self.model objectForKey:@"pics"]);
    self.footLabel.text = [NSString stringWithFormat:@"￥%.2f",[[self.model objectForKey:@"sl_money"]floatValue]];
    [self.view addSubview:self.headView];
//        self.bageIndex = 0;
    [self.headView addSubview:self.headBrandView];
    [self.headView addSubview:self.MiddleView];
    // 测试字串
    NSString *s = [self.model objectForKey:@"description"];
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    NSString *s1 = [self.model objectForKey:@"sl_description"];
    UIFont *font1 = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size1 = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize1 = [s1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByCharWrapping];

    self.MiddleView.frame = CGRectMake(0, self.headBrandView.maxY, HNCFWidth, labelsize.height+labelsize1.height+40+75+50);
    self.headView.frame = CGRectMake(0, 0, HNCFWidth, self.MiddleView.maxY);
//    self.headView.backgroundColor = [UIColor redColor];
//    self.MiddleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.footView];
    [self.footView addSubview:self.footLabel];
    [self.footView addSubview:self.footButton];
    [self.footView addSubview:self.shopButton];
    [self.shopButton addSubview:self.countLabel];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didSelectRight
{
    [MJProgressHUD showHUDWithText1:@"加载中.."];
    NSDictionary *userInfo = [HNCFUserDefaultsUtil globalObjectForKey:kMTCurrentUserInfo];
    
    if (!self.isCollection) {
        [HNCFRequestManager fetchAddCollect:@{@"uid":[userInfo objectForKey:@"uid"],@"addcollectid":[self.model objectForKey:@"id"]} success:^(id result) {
            NSInteger code = [[result objectForKey:@"code"]integerValue];
            if (code ==0) {
                [MJProgressHUD hide1];
                [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
                self.isCollection = YES;
                [self.naView setHomeBannerData:@"菜单详情" locationImage:YES rightButton:NO leftButton:NO rightImage:[UIImage imageNamed:@"ic_collect_on"]];
                
            }else{
                [MJProgressHUD hide1];
                [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
                
            }
            
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        
        [HNCFRequestManager fetchCancelCollect:@{@"uid":[userInfo objectForKey:@"uid"],@"addcollectid":[self.model objectForKey:@"id"]} success:^(id result) {
            NSInteger code = [[result objectForKey:@"code"]integerValue];
            if (code ==0) {
                [MJProgressHUD hide1];
                [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
                self.isCollection = NO;
                [self.naView setHomeBannerData:@"菜单详情" locationImage:YES rightButton:NO leftButton:NO rightImage:[UIImage imageNamed:@"ic_collect"]];
                
                
            }else{
                [MJProgressHUD hide1];
                [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
                
            }
            
        } failure:^(NSError *error) {
            
        }];
        
    }
}
#pragma
#pragma mark - HNCFHeadBrandViewDelegate
- (void)HNCFHeadBrandView:(HNCFHeadBrandView *)bannerView didSelectItem:(NSDictionary *)itemData Index:(NSInteger)index;
{
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
{
    return self.headView;
}
#pragma
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.conmentList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellIdentifier = @"HNCFComMentCell";
    HNCFComMentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HNCFComMentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    id model = [self.conmentList objectAtIndex:indexPath.row];
    [cell comment:model];
    
    return cell;
}
#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable5) withObject:nil afterDelay:1.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable5) withObject:nil afterDelay:1.0f];
}
#pragma mark - Refresh and load more methods

- (void) refreshTable5
{
    /*
     
     Code to actually refresh goes here.
     
     */
    self.pageIndex = 1;
    [_mutaArray removeAllObjects];
//    //    [self.orderArray removeAllObjects];
    [self CommentRequest];
    self.mainTableView.pullLastRefreshDate = [NSDate date];
    self.mainTableView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable5
{
    /*
     
     Code to actually load more data goes here.
     
     */
    self.pageIndex ++;
    [self CommentRequest];
//
    
    self.mainTableView.pullTableIsLoadingMore = NO;
}
- (void)HNCFHomeDetailIndex:(HNCFHomeDetail *)headView index:(id)model;
{
    HNCFHomeDetailViewController *homeDetailViewController = [[HNCFHomeDetailViewController alloc]init];
    homeDetailViewController.model = model;
    [self.navigationController pushViewController:homeDetailViewController animated:YES];

}
- (void)footButtonSlect
{
    NSDictionary *userInfo = [HNCFUserDefaultsUtil globalObjectForKey:kMTCurrentUserInfo];
    if ([self.cityString length]==0) {
        self.cityString = @"";
    }
    [HNCFRequestManager fetchShopAdd:@{@"pay_type":@"5",
                                       @"goodsid":[self.model objectForKey:@"sl_id"],
                                       @"shopid":[self.model objectForKey:@"id"],
                                       @"shopname":[self.model objectForKey:@"sl_title"],
                                       @"gonumber":@"1",
                                       @"moneycount":[self.model objectForKey:@"sl_money"],
                                       @"add_street":self.cityString,
                                       @"add_username":[userInfo objectForKey:@"username"],
                                       @"add_phone":[userInfo objectForKey:@"mobile"]} success:^(id result) {
        NSInteger code = [[result objectForKey:@"code"]integerValue];
        if (code ==0) {
            [MJProgressHUD showHUDWithText:@"成功加入购物车" duration:1.0];
            NSLog(@"%@",result);
            self.bageIndex ++;
            //            [self setBadgeValue:[NSString stringWithFormat:@"%ld",(long)self.bagIndex] atTabIndex:2];
            self.countLabel.text = [NSString stringWithFormat:@"%ld",self.bageIndex];
            [HNCF_APP_DELEGATE.tabBarController setbarge1:self.bageIndex];
            
        }
        
    } failure:^(NSError *error) {
        
    }];

}
- (void)shopButtonSlect
{
    if (self.bageIndex == 0) {
        [MJProgressHUD showHUDWithText:@"购物车还未添加商品" duration:1.0];
    }else{
    self.bageIndex = 0;
    [HNCFUserDefaultsUtil setGlobalObject:@{@"bageIndex":@"0"} forKey:@"bageIndex"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [HNCF_APP_DELEGATE.tabBarController switchToViewControllerAtIndex:2];

    [HNCF_APP_DELEGATE.tabBarController setbarge1:self.bageIndex];
    }

}
@end
