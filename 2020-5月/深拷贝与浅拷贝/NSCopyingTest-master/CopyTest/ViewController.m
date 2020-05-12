//
//  ViewController.m
//  CopyTest
//
//  Created by Daruo on 2018/7/19.
//  Copyright © 2018年 BeeSmart. All rights reserved.
//

#import "ViewController.h"
#import "Apple.h"
#import "Orange.h"
@interface ViewController ()

@end

/**
 总结：

 Foundation框架下的类，并不是所有的都支持深拷贝，浅拷贝，只有那些遵循了NSCopying 或者 NSMultableCopying 协议的类，才可以进行拷贝操作。
 区别深浅拷贝的唯一标准就是：对象地址是否相同，如果相同，就是浅拷贝，反之则为深拷贝。
 multableCopy 方法是执行深拷贝。如果该对象是容器类型，那么，返回的对象是深拷贝后的对象，但是这个对象里元素，还是之前对象里的元素，地址并没有变化。如果希望深拷贝后，返回的容器类型的对象里的元素也是深拷贝类型的，那么需要对容器内的元素也执行拷贝方法。

 作者：达若漠沙
 链接：https://www.jianshu.com/p/cbb092ff981b
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self testString];
    
    [self testNoNSCopying];

//    [self testNSCopying];

    
}
- (void)testString{
    //非容器型对象
    NSString * testStr = @"123";
    NSString * copyStr = [testStr copy];// 这里是浅拷贝
    NSString * deepCopyStr = [testStr mutableCopy];//深拷贝
    
    NSLog(@"%@-----%@-------%@",testStr,copyStr,deepCopyStr);
    testStr = @"this is new str";
    NSLog(@"%@-----%@-------%@",testStr,copyStr,deepCopyStr);
    NSLog(@"%p----%p-----%p",testStr,copyStr,deepCopyStr);
    
    /**
     对于NSString类型的对象，使用copy 和 multableCopy方法都会返回一个新的对象，testStr的值更新后，不影响copyStr 和 deepCopyStr.
     */
}
- (void)testNoNSCopying{
    //Apple 类 没有实现NSCopying协议
    Apple *apple01 = [[Apple alloc] initWithColor:@"red" AndTaste:@"sweet"];
    Apple *apple02 =  [[Apple alloc] initWithColor:@"orange" AndTaste:@"sour"];
    NSArray *array = @[apple01,apple02];
    NSArray *array1 = [array copy]; //浅拷贝
    NSMutableArray *array2= [array mutableCopy]; //数组深拷贝 元素浅拷贝
    NSLog(@"%p-----%p------%p",array,array1,array2);
    NSLog(@"\narray---%@\narray1----%@\narray2------%@",array[0],array1[0],array2[0]);
    
    Apple *getApple01 = array[0];
    Apple *getCopyApple01 = array1[0];
    Apple *getMutCopyApple01 = array2[0];
    
    getApple01.color = @"newRed";
    NSLog(@"%@-----%@-------%@",getApple01.color,getCopyApple01.color,getMutCopyApple01.color);

    
    NSMutableArray *array7 = [NSMutableArray array];
    for (Apple *apple in array) {
        [array7 addObject:[apple copy]];
    }
    
    NSLog(@"%p----%p",array,array7);
    NSLog(@"%@---%@",array[0],array7[0]);
    /**
     对于NSArray 而言，copy 是浅拷贝，因为array和 array1 都指向相同的内存地址，而multableCopy是深拷贝 因为array2指向了不同的内存地址。不过，需要注意一点，无论是深拷贝，还是浅拷贝，对于数组元素而言，都是浅拷贝，因为三个数组相同下标对应元素占用的内存地址是一样的。这里仅打印了三个数组中的第一个元素，以示说明。
     */
}
- (void)testNSCopying{
    //Orange 类 实现了NSCopying协议
    Orange *orange01 = [[Orange alloc] initWithColor:@"red" AndTaste:@"sweet"];
    Orange *orange02 =  [[Orange alloc] initWithColor:@"orange" AndTaste:@"sour"];
    NSArray *array3 = @[orange01,orange02];
    NSArray *array4 = [array3 copy];  //浅拷贝
    NSMutableArray *array5 = [array3 mutableCopy];//深拷贝 但数组元素是浅拷贝
    NSMutableArray *array6 = [[NSMutableArray alloc] initWithArray:array3 copyItems:YES];//深拷贝，且数组元素也是深拷贝
    NSLog(@"%p-----%p------%p-----%p",array3,array4,array5,array6);
    NSLog(@"\narray3---%@\narray4----%@\narray5-----%@\narray6----%@",array3[0],array4[0],array5[0],array6[0]);
    
    
    NSMutableArray *array7 = [NSMutableArray array];
    for (Orange *orange in array3) {
        [array7 addObject:[orange copy]];
    }
    
    NSLog(@"%p----%p",array3,array7);
    NSLog(@"%@---%@",array3[0],array7[0]);
    
    /**
     对于Orange类而言，遵循了NSCopying协议，且实现了copyWithZone方法，这样的话，array6就可以使用initWithArray: copyItems： 方法进行构造。因为Orange类可以进行copy操作，所以数组 array6 是array3深拷贝而来，且数组元素也是深拷贝。因为数组的内存地址 以及数组元素内存地址与array3 都不相同。
     如果不使用 initWithArray: copyItems 方法，也可以通过对array3 数组里的orange对象 进行遍历copy,也能实现同样的效果。
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
