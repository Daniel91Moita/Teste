//
//  BookDetailsViewController.m
//  BookStore_DanielMoita
//
//  Created by itsector on 03/02/2021.
//

#import "BookDetailsViewController.h"
#import "Book.h"
@interface BookDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyLink;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UISwitch *favouriteSwitch;
@end

@implementation BookDetailsViewController
- (IBAction)setFavourite:(UISwitch *)sender {

    NSMutableArray *favouritedBooks = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favourites"]];
    
    if(sender.on){
        [favouritedBooks addObject: self.book.bookID];
    } else {
        [favouritedBooks removeObject:self.book.bookID];
    }
    [[NSUserDefaults standardUserDefaults] setObject:favouritedBooks forKey:@"favourites"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)labelTaped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: self.book.bookBuyLink] options:@{} completionHandler:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.book.bookTitle;
//    ghost writer... ver problema e fazer cenas
//    self.authorLabel.text = self.book.bookAuthor;
    self.buyLink.textColor = [UIColor blueColor];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTaped)];
    tapGestureRecognizer.numberOfTapsRequired = 1;

    [self.buyLink addGestureRecognizer:tapGestureRecognizer];
    self.buyLink.userInteractionEnabled = YES;
    
    self.buyLink.text = self.book.bookBuyLink;
    self.descriptionLabel.text = self.book.bookDescription;
    
    NSMutableArray *favouritedBooks = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favourites"]];
    if ([favouritedBooks containsObject:self.book.bookID]) {
        [self.favouriteSwitch setOn:YES];
    } else {
        [self.favouriteSwitch setOn:NO];
    }
}
@end
