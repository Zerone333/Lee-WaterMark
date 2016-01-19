//
//  ViewController.m
//  watermark
//
//  Created by 李艺真 on 16/1/17.
//  Copyright © 2016年 李艺真. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Mark.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addTextMark:(id)sender {
    UIImage *image = [UIImage imageNamed:@"3"];
    UIImage *waterMarkImage = [UIImage markImageWithOriginImage:image logoImage:[UIImage imageNamed:@"mark"]];
    _imageV.image = waterMarkImage;
}


- (IBAction)addImageMark:(id)sender {
    UIImage *image = [UIImage imageNamed:@"3"];
    UIImage *waterMarkImage = [UIImage markImageWithText:@"你最美！" image:image];
    _imageV.image = waterMarkImage;
}

@end
