//
//  STAvatarsViewController.m
//  Stasher
//
//  Created by Bhushan on 30/04/15.
//  Copyright (c) 2015 OAB. All rights reserved.
//

#import "STAvatarsViewController.h"

@interface STAvatarsViewController ()

@end

@implementation STAvatarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headerLabel setFont:[UIFont FontForHeader]];
    NSMutableArray *firstSection = [[NSMutableArray alloc] init];
    NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    for (int i=1; i<9; i++) {
        [firstSection addObject:[NSString stringWithFormat:@"avtar_0%d", i]];
        [secondSection addObject:[NSString stringWithFormat:@"avtar_0%d", i]];
    }
    self.dataArray = [[NSArray alloc] initWithObjects:firstSection, secondSection, nil];
    
    //self.dataArray = [[NSArray alloc] initWithObjects:@"avtar_01",@"avtar_02", @"avtar_03",@"avtar_04",@"avtar_05",@"avtar_06",@"avtar_07",@"avtar_08",nil];
    
    UINib *cellNib = [UINib nibWithNibName:@"AvatarCollectionViewCell" bundle:nil];
    [self.avatarCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"AvatarCollectionViewCell"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(47, 47)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.avatarCollectionView setCollectionViewLayout:flowLayout];
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

- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   
    NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    return [sectionArray count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
    NSString *cellData = [data objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"AvatarCollectionViewCell";
    
    AvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell.avatarImgView setImage:[UIImage imageNamed:cellData]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    NSString *cellData = [data objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(avatarSelectedWithImgName:)]) {
        [self.delegate avatarSelectedWithImgName:cellData];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
