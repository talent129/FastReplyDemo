//
//  ReplyDetailController.m
//  ProjectDemo
//
//  Created by luckyCoderCai on 2017/9/28.
//  Copyright © 2017年 luckyCoderCai. All rights reserved.
//

#import "ReplyDetailController.h"
#import "Model.h"
#import "Define.h"

@interface ReplyDetailController ()

@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topOneLabel;
@property (nonatomic, strong) UILabel *topTwoLabel;
@property (nonatomic, strong) UITextField *topOneField;
@property (nonatomic, strong) UITextField *topTwoField;

@property (nonatomic, strong) UILabel *btmDesLabel;
@property (nonatomic, strong) UIView *btmView;

@property (nonatomic, strong) NSMutableArray *dataArray;//数据

@property (nonatomic, copy) NSString *selectedIcon;
@property (nonatomic, strong) UIImageView *selectedImgView;

@end

@implementation ReplyDetailController

#pragma mark -lazy load
- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        
    }
    return _iconImgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor grayColor];
        _nameLabel.font = Sys_Font(16);
    }
    return _nameLabel;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UILabel *)topOneLabel
{
    if (!_topOneLabel) {
        _topOneLabel = [[UILabel alloc] init];
        _topOneLabel.textColor = [UIColor lightGrayColor];
        _topOneLabel.font = Sys_Font(16);
        _topOneLabel.text = @"名称";
    }
    return _topOneLabel;
}

- (UILabel *)topTwoLabel
{
    if (!_topTwoLabel) {
        _topTwoLabel = [[UILabel alloc] init];
        _topTwoLabel.textColor = [UIColor lightGrayColor];
        _topTwoLabel.font = Sys_Font(16);
        _topTwoLabel.text = @"文本";
    }
    return _topTwoLabel;
}

- (UITextField *)topOneField
{
    if (!_topOneField) {
        _topOneField = [[UITextField alloc] init];
        _topOneField.textColor = [UIColor blackColor];
        _topOneField.placeholder = @"简短描述";
    }
    return _topOneField;
}

- (UITextField *)topTwoField
{
    if (!_topTwoField) {
        _topTwoField = [[UITextField alloc] init];
        _topTwoField.textColor = [UIColor blackColor];
        _topTwoField.placeholder = @"计划发送文本";
    }
    return _topTwoField;
}

- (UILabel *)btmDesLabel
{
    if (!_btmDesLabel) {
        _btmDesLabel = [[UILabel alloc] init];
        _btmDesLabel.textColor = [UIColor lightGrayColor];
        _btmDesLabel.font = Sys_Font(16);
    }
    return _btmDesLabel;
}

- (UIView *)btmView
{
    if (!_btmView) {
        _btmView = [[UIView alloc] init];
        _btmView.backgroundColor = [UIColor whiteColor];
    }
    return _btmView;
}

- (UIImageView *)selectedImgView
{
    if (!_selectedImgView) {
        _selectedImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _selectedImgView.image = Image(@"emoji-solid-yellow");
    }
    return _selectedImgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.title = @"回复详情";
    
    [self handleData];
    
    [self createUI];
    
    //重写返回事件
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"email-thanks"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)notification:(NSNotification *)noti
{
    self.nameLabel.text = self.topTwoField.text;
    if (StrEmpty(self.nameLabel.text)) {
        [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom).mas_offset(20);
        }];
    } else {
        [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).mas_offset(-10);
            make.top.equalTo(self.mas_topLayoutGuideBottom).mas_offset(20);
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)leftBtnAction
{
    if (StrEmpty(self.topOneField.text)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"名称为空" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    if (!self.isNewFlag) {
        self.model.icon = self.selectedIcon;
        self.model.name = self.topOneField.text;
    }
    
    if (self.refreshBlock) {
        
        Model *model = [[Model alloc] init];
        model.icon = self.selectedIcon;
        model.name = self.topOneField.text;
        
        self.refreshBlock(model);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handleData
{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ModelList" ofType:@"plist"]];
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        Model *model = [Model modelWithDic:array[i]];
        [self.dataArray addObject:model];
    }
}

- (void)createUI
{
    [self.view addSubview:self.iconImgView];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.topOneLabel];
    [self.topView addSubview:self.topOneField];
    [self.topView addSubview:self.topTwoLabel];
    [self.topView addSubview:self.topTwoField];
    [self.view addSubview:self.btmDesLabel];
    [self.view addSubview:self.btmView];
    
    if (StrEmpty(self.model.name)) {
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.mas_topLayoutGuideBottom).mas_offset(20);
        }];
    } else {
        [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).mas_offset(-10);
            make.top.equalTo(self.mas_topLayoutGuideBottom).mas_offset(20);
        }];
    }
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).mas_offset(5);
        make.top.equalTo(self.iconImgView);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(self.iconImgView.mas_bottom).mas_offset(20);
        make.height.equalTo(@80);
    }];
    
    [self.topOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.top.equalTo(@15);
    }];
    
    [self.topOneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@100);
        make.trailing.equalTo(@-10);
        make.centerY.equalTo(self.topOneLabel);
        make.height.equalTo(@39.9);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.top.equalTo(@40);
        make.height.equalTo(@0.5);
    }];
    
    [self.topTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.top.equalTo(line).mas_offset(15);
    }];
    
    [self.topTwoField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@100);
        make.trailing.equalTo(@-10);
        make.height.equalTo(@40);
        make.centerY.equalTo(self.topTwoLabel);
    }];
    
    [self.btmDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.top.equalTo(self.topView.mas_bottom).mas_offset(50);
    }];
    
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btmDesLabel.mas_bottom).mas_offset(5);
        make.leading.and.trailing.equalTo(@0);
        make.height.equalTo(@200);
    }];
    
    CGFloat pointX = (SCREEN_Width - 5 * 60)/6.0;
    CGFloat pointY = (SCREEN_Width - 5 * 60)/6.0;
    CGFloat btnWidth = 60;
    CGFloat btnHeight = 60;
    CGFloat paddingX = pointX;
    CGFloat paddingY = 0;
    
    NSInteger lineCount;
    if (self.dataArray.count % 5 == 0) {
        lineCount = self.dataArray.count/5;
    } else {
        lineCount = self.dataArray.count/5 + 1;
    }
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        NSLog(@"===%d===%d", i, i % 5);
        
        if (i % 5 == 0 && i != 0) {
            pointX = (SCREEN_Width - 5 * 60)/6.0;//恢复
            pointY += (btnHeight + paddingY);
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        Model *model = self.dataArray[i];
        [btn setImage:Image(model.icon) forState:UIControlStateNormal];
        
        [self.btmView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(pointX);
            make.top.mas_equalTo(pointY);
            make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
        }];
        
        if (!self.isNewFlag) {
            if ([model.icon isEqualToString:self.model.icon]) {
                
                self.selectedIcon = model.icon;
                [self.btmView insertSubview:self.selectedImgView belowSubview:btn];
                [self.selectedImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(btn);
                }];
            }
        } else {
            
            NSInteger mid = self.dataArray.count / 2;
            // 5 / 2 = 2
            // 6 / 2 = 3
            
            Model *midModel = self.dataArray[mid];
            self.selectedIcon = midModel.icon;
            
            self.iconImgView.image = Image(midModel.icon);
            
            if (i == mid) {
                [self.btmView insertSubview:self.selectedImgView belowSubview:btn];
                [self.selectedImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(btn);
                }];
            }
        }
        
        pointX += (btnWidth + paddingX);
    }
    
    if (!self.isNewFlag) {
        self.iconImgView.image = Image(self.model.icon);
        self.nameLabel.text = self.model.name;
        
        self.topOneField.text = self.model.name;
        self.topTwoField.text = self.model.name;
    }
}


- (void)btnClick:(UIButton *)btn
{
    NSLog(@"==click btn, tag: %ld", btn.tag);
    
    Model *model = self.dataArray[btn.tag];
    self.iconImgView.image = Image(model.icon);
    self.selectedIcon = model.icon;
    
    [self.selectedImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(btn);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
