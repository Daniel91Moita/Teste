//
//  ViewController.m
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import "ViewController.h"
#import "BookCollectionViewCell.h"
#import "BookDetailsViewController.h"
#import "Book.h"
#import "Service.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSArray *books;
@property (strong, nonatomic) NSArray *favouriteBooks;
@property (strong, nonatomic) Service *service;
@property (nonatomic) BOOL isShowingFavourites;
@end

@implementation ViewController
- (IBAction)showFavouritesButtonPressed:(UIButton *)sender {
    self.isShowingFavourites = !self.isShowingFavourites;
    [self.collectionView reloadData];
}

- (void)configureFavouriteBooks {
    NSMutableArray *favouritedBooks = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favourites"]];
//    self.favouriteBooks = [[NSArray alloc]initWithArray:favouritedBooks];
    
    NSMutableArray *filteredFavourites = [NSMutableArray new];
    
    for (NSString *identifier in favouritedBooks) {
        for (Book *book in self.books){
            if ([identifier isEqual: book.bookID]) {
                [filteredFavourites addObject:book];
            }
        }
    }
    self.favouriteBooks = [[NSMutableArray alloc] initWithArray:filteredFavourites];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureFavouriteBooks];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowingFavourites = NO;
    [self setupCollectionView];
    self.service = [Service new];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"BookCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
        self.collectionView.backgroundColor = [UIColor clearColor];
    [self.service getBookList:^(NSArray * _Nonnull object) {
        self.books = object;
        [self configureFavouriteBooks];
        [self.collectionView reloadData];
    }];
    
    //Create flow layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //Force Horizontal Scroll
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 10.0;
    
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
}

-(CGSize)collectionView:(UICollectionView *) collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = self.collectionView.bounds.size.width - 30;
    return CGSizeMake(width / 2.0, width / 2.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

- (void)setupCollectionView
{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isShowingFavourites) {
        return self.favouriteBooks.count;
    } else {
        return self.books.count;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BookDetailsViewController *detailsVC = [storyboard instantiateViewControllerWithIdentifier:@"BookDetails"];
    detailsVC.book = self.books[indexPath.row];
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellIdentifier";
    
    BookCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath: indexPath];
    if (cell == nil) {
        cell = [BookCollectionViewCell new];
    }
    if (self.isShowingFavourites) {
        [cell configureCellWithBook:self.favouriteBooks[indexPath.row]];
    } else {
        [cell configureCellWithBook:self.books[indexPath.row]];
    }
    return cell;
}
@end
