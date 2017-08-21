# ImoDynamicTableView

[![Version](https://img.shields.io/cocoapods/v/ImoDynamicTableView.svg?style=flat)](http://cocoadocs.org/docsets/ImoDynamicTableView)
[![License](https://img.shields.io/cocoapods/l/ImoDynamicTableView.svg?style=flat)](http://cocoadocs.org/docsets/ImoDynamicTableView)
[![Platform](https://img.shields.io/cocoapods/p/ImoDynamicTableView.svg?style=flat)](http://cocoadocs.org/docsets/ImoDynamicTableView)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 7.1

## Installation

ImoDynamicTableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

    pod "ImoDynamicTableView"

## Example implementation


Usee [Cell & CellSource Template](https://github.com/imodeveloper/ImoDynamicTableView/tree/master/Templates#cell--cellsource-template) to make your implementation easyer.


### This is how implementation in view controller looks like

```objc

@implementation ImoReadmeViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  NSMutableArray *tableSection = [NSMutableArray new];

  for (int i = 0; i < 100; i++) {

      ImoReadmeCellSource *source = [ImoReadmeCellSource new];

      /*
      In this case we have static height for cell, but if you want you can use autolayout 
      for in your cell and then the height of the cell will be automaticaly caluculated.
      */
      source.staticHeightForCell = 45;

      /*
      Generate a random name
      */
      source.title = [LoremIpsum name]; 

      /*
      IBOutlet from your tableView wich need to be ImoDynamicTableView class
      */  
      [tableSection addObject:source];
  }

  [self.tableView.source addObject:tableSection];
}

@end

```

## Author

Devsteam.mobi, imodeveloperlab@gmail.com

## License

ImoDynamicTableView is available under the MIT license. See the LICENSE file for more info.


