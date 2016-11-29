//
//  ViewController.m
//  仿淘宝购买页面
//
//  Created by 姚祚成 on 16/11/29.
//  Copyright © 2016年 EMYZC. All rights reserved.
//

#import "ViewController.h"
#import "TaoBaoView.h"
@interface ViewController ()
@property (nonatomic ,strong) UIView *maskView;

@property (nonatomic, strong) UIView *taobaoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor magentaColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIWindow *rootWindow = [[UIApplication sharedApplication].windows lastObject];
    
    
    self.maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    self.maskView.alpha = 0;
    [rootWindow addSubview:self.maskView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.maskView addGestureRecognizer:gesture];
    self.taobaoView = [[TaoBaoView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/2)];
    [rootWindow addSubview:self.taobaoView];
    
}
- (IBAction)buyGoods:(UIButton *)sender {
    //当前这个页面绕x轴旋转
    CATransform3D transform = CATransform3DIdentity;
    //出现问题
//   transform = CATransform3DMakeRotation(M_PI/8, 1, 0, 0);
    transform = CATransform3DScale(transform, 0.9, 0.9, 1);
    
    CGRect rect = self.taobaoView.frame;
    rect.origin.y = self.view.frame.size.height/2;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha = 0.5;
//        self.view.layer.transform = CATransform3DRotate(transform,M_PI/8, 1, 0, 0);
//        self.view.layer.transform = CATransform3DScale(transform, 0.9, 0.9, 1);
        self.view.layer.transform = [self CATransform3DPerspect:transform withCenter:CGPointMake(0, 0) withIDz:6000];
    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 animations:^{
           CATransform3D transform = CATransform3DIdentity;
           transform =  CATransform3DTranslate(transform, 0, self.view.frame.size.height * -0.08, 0);
           self.view.layer.transform = CATransform3DScale(transform, 0.8, 0.8, 1);
           self.taobaoView.frame = rect;
       }];
    }];
}

- (CATransform3D)CATransform3DMakePerspective:(CGPoint)center with:(CGFloat)idz{
    CATransform3D transformToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D tansformback = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D trans = CATransform3DIdentity;
    trans.m24 = -1/idz;
    return CATransform3DConcat(CATransform3DConcat(transformToCenter, trans), tansformback);
}

- (CATransform3D)CATransform3DPerspect:(CATransform3D)t withCenter:(CGPoint)center withIDz:(CGFloat)idz{
    return CATransform3DConcat(t, [self CATransform3DMakePerspective:center with:idz]);
}


- (void)dismiss{
    
 
    
    [UIView animateWithDuration:0.5 animations:^{
        CATransform3D transform = CATransform3DIdentity;
//        transform =  CATransform3DTranslate(transform, 0, self.view.frame.size.height, 0);
        self.view.layer.transform = CATransform3DScale(transform, 1, 1, 1);
        CGRect rect = self.taobaoView.frame;
        rect.origin.y = self.view.frame.size.height;
        self.taobaoView.frame = rect;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.maskView.alpha = 0.0;
            self.view.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
           
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
