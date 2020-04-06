#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PizzaSize) {
  PizzaSizeSmall,
  PizzaSizeMedium,
  PizzaSizeLarge
};

@interface Pizza : NSObject {
  PizzaSize size;
  NSArray *toppings;
}

@property (nonatomic)         PizzaSize  size;
@property (nonatomic, assign) NSArray   *toppings;

- (instancetype)init:(PizzaSize)size toppings:(NSArray *)toppings;

@end


@implementation Pizza

@synthesize size;
@synthesize toppings;

- (instancetype)init:(PizzaSize)size toppings:(NSArray *)toppings {
  self = [super init];
  if(self) {
    self.size = size;
    self.toppings = toppings;
  }
  return self;
}

@end

@interface Kitchen : NSObject

- (Pizza *)makePizzaWithSize:(PizzaSize)size toppings:(NSArray *)toppings;

@end

@implementation Kitchen

- (Pizza *)makePizzaWithSize:(PizzaSize)size toppings:(NSArray *)toppings
{
  return [[Pizza alloc] init: size toppings:toppings];
}

@end

int main(int argc, const char * argv[])
{

  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

  NSLog(@"Please pick your pizza size and toppings:");

  Kitchen *restaurantKitchen = [Kitchen new];

  while (TRUE) {
    // Loop forever

    NSLog(@"> ");
    char str[100];
    fgets (str, 100, stdin);

    NSString *inputString = [[NSString alloc] initWithUTF8String:str];
    inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSLog(@"Input was %@", inputString);

    // Take the first word of the command as the size, and the rest as the toppings
    NSArray *commandWords = [inputString componentsSeparatedByString:@" "];

    // And then send some message to the kitchen...
    PizzaSize size = PizzaSizeSmall;

    if([[commandWords objectAtIndex: 0] isEqualToString:@"large"]) {
      size = PizzaSizeLarge;
    } else if([[commandWords objectAtIndex: 0] isEqualToString:@"medium"]) {
      size = PizzaSizeMedium;
    }

    [restaurantKitchen makePizzaWithSize:size toppings: [commandWords subarrayWithRange:NSMakeRange(1, commandWords.count - 1)]];
  }

  [pool drain];

  return 0;
}

