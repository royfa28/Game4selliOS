//
//  ProductTableViewController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 3/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "ProductTableViewController.h"
#import "ProductCell.h"

@interface ProductTableViewController ()

@end

@implementation ProductTableViewController{

    NSMutableArray<FIRDocumentSnapshot *> *_products;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [[NSMutableArray alloc] init];
    FIRFirestore *db = FIRFirestore.firestore;
    FIRCollectionReference *productsReference = [db collectionWithPath:@"Products"];

    
    [productsReference getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if(snapshot == nil){
            NSLog(@"Error fetching document: %@", error);
        }else{
            for (FIRDocumentSnapshot *document in snapshot.documents){
                
                self->_products = [snapshot.documents copy];
                [self->data addObject:document.data];
                [self.tableView reloadData];
            }
        }
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"products" forIndexPath:indexPath];
    
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier:@"product"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"product"];
    }
    
    FIRDocumentSnapshot *product = _products[indexPath.row];
    
//    cell.textLabel.text = product[@"Name"];
    cell.productName.text = product[@"Name"];
    cell.productPlatform.text = [NSString stringWithFormat:@"Platform %@", product[@"Platform"]];
    cell.productPrice.text = [NSString stringWithFormat:@"$ %@", product[@"Price"]];
    
    // Get image URL
    NSString *result = product[@"photoUrl"];
    NSLog(@"%@", result);
    NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString:result]];
    cell.productImage.image = [UIImage imageWithData:imageData];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FIRDocumentSnapshot *product = _products[indexPath.row];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    FIRDocumentSnapshot *product = _products[indexPath.row];
    if([segue.identifier isEqualToString:@"showProductDetail"]) {
        
        ProductDetailViewController *destViewController = segue.destinationViewController;
        destViewController.products = product;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
@end
