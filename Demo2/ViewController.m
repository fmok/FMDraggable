//
//  ViewController.m
//  Demo2
//
//  Created by fm on 2017/5/26.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Draggable.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof(self)weakSelf = self;
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.imgView makeDraggable];
}

- (void)viewDidLayoutSubviews
{
    [self.imgView updateSnapPoint];
}

#pragma mark - getter & setter
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imgView.backgroundColor = [UIColor whiteColor];
        _imgView.image = [UIImage imageNamed:@"timg.jpg"];
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
