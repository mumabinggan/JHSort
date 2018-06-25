//
//  ViewController.m
//  JHSort
//
//  Created by muma on 2018/1/30.
//  Copyright © 2018年 muma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int a[] = {32, 12, 43, 23, 55, 553, 2, 10, 99};
    int len = sizeof(a)/sizeof(int);
    //冒泡排序
    //[self bubbleSort:a length:len];
    //简单选择排序
    //[self easySelectSort:a length:len];
    //直接插入排序
    //[self directInsertSort:a length:len];
    //希尔排序
    //[self hillSort:a length:len];
    //堆排序
    //[self heapSort:a length:len];
    //快速排序
    //[self quickSort:a beginIndex:0 endIndex:len-1];
    //归并排序
    int b[len];
    [self mergeSort:a left:0 right:len-1 temp:b];
    
    [self printArray:a length:len];
}

//冒泡排序
- (void)bubbleSort:(int *)a length:(int)length {
    for (int i = 0; i < length-1; ++i) {
        for (int j = 0; j < length-i-1; ++j) {
            if (a[j] > a[j+1]) {
                int temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
            }
        }
    }
}

//冒泡排序优化
- (void)bubbleSortOptimization:(int *)a length:(int)length {
    BOOL flag = YES;
    for (int i = 0; i < length-1 && flag; ++i) {
        flag = NO;
        for (int j = 0; j < length-i-1; ++j) {
            if (a[j] > a[j+1]) {
                int temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
                flag = YES;
            }
        }
    }
}

//简单选择排序
- (void)easySelectSort:(int *)a length:(int)length {
    for (int i = 0; i < length - 1; ++i) {
        int min = i;
        for (int j = i+1; j < length; ++j) {
            if (a[min] > a[j]) {
                min = j;
            }
        }
        if (i != min) {
            int temp = a[i];
            a[i] = a[min];
            a[min] = temp;
        }
    }
}

//直接插入排序
- (void)directInsertSort:(int *)a length:(int)length {
    for (int i = 1; i < length; ++i) {
        int curIndex = i;
        for (int j = i-1; j >= 0; --j) {
            if (a[curIndex] < a[j]) {
                int temp = a[curIndex];
                a[curIndex] = a[j];
                a[j] = temp;
                curIndex = j;
            }
            else {
                break;
            }
        }
    }
}

//希尔排序
- (void)hillSort:(int *)a length:(int)length {
    for (int gap = length/2; gap > 0; gap/=2) {
        for (int i = gap; i < length; ++i) {
            int curIndex = i;
            for (int j = i - gap; j >= 0; j-=gap) {
                if (a[curIndex] < a[j]) {
                    int temp = a[curIndex];
                    a[curIndex] = a[j];
                    a[j] = temp;
                    curIndex = j;
                }
                else {
                    break;
                }
            }
        }
    }
}

//堆排序
- (void)heapSort:(int *)a length:(int)length {
    for (int num = length/2-1; num >= 0; --num) {
        [self bigTopDeap:a curIndex:num length:length];
    }
    
    for (int num = length-1; num > 0; --num) {
        int temp = a[num];
        a[num] = a[0];
        a[0] = temp;
        
        [self bigTopDeap:a curIndex:0 length:num];
    }
}

//构建大顶堆
- (void)bigTopDeap:(int *)a curIndex:(int)curIndex length:(int)length {
    int indexLeft = 2 * curIndex + 1;
    int indexRight = 2 * curIndex + 2;
    int temp = a[curIndex];
    if ([self hasNoneChild:curIndex length:length]) {
        return;
    }
    else if ([self onlyHasLeftChild:curIndex length:length]) {
        if (a[curIndex] < a[indexLeft]) {
            a[curIndex] = a[indexLeft];
            a[indexLeft] = temp;
            [self bigTopDeap:a curIndex:indexLeft length:length];
        }
    }
    else {
        if (a[indexLeft] > a[indexRight]) {
            a[curIndex] = a[indexLeft];
            a[indexLeft] = temp;
            [self bigTopDeap:a curIndex:indexLeft length:length];
        }
        else {
            a[curIndex] = a[indexRight];
            a[indexRight] = temp;
            [self bigTopDeap:a curIndex:indexRight length:length];
        }
    }
}

//只有一个左子结点
- (BOOL)onlyHasLeftChild:(int)curIndex length:(int)length {
    return 2 * curIndex + 2 >= length;
}

//没有子结点
- (BOOL)hasNoneChild:(int)curIndex length:(int)length {
    return 2 * curIndex + 1 >= length;
}

//归并排序
- (void)mergeSort:(int *)a left:(int)leftIndex right:(int)rightIndex temp:(int *)tempArray {
    if (leftIndex < rightIndex) {
        int mid = (leftIndex + rightIndex)/2;
        [self mergeSort:a left:leftIndex right:mid temp:tempArray];
        [self mergeSort:a left:mid+1 right:rightIndex temp:tempArray];
        [self merge:a left:leftIndex mid:mid right:rightIndex temp:tempArray];
    }
}

- (void)merge:(int *)a left:(int)leftIndex mid:(int)midIndex right:(int)rightIndex temp:(int *)tempArray {
    int j = leftIndex;
    int i = midIndex;
    int m = 0;
    for (i = midIndex+1; i <= rightIndex; ++i) {
        int temp = a[i];
        for (; j <= midIndex; ++j) {
            if (temp > a[j]) {
                tempArray[m++] = a[j];
            }
            else {
                tempArray[m++] = a[i];
                break;
            }
        }
        if (j > midIndex) {
            break;
        }
    }
    while (i <= rightIndex) {
        tempArray[m++] = a[i++];
    }
    while (j <= midIndex) {
        tempArray[m++] = a[j++];
    }
    int t = 0;
    while (leftIndex <= rightIndex) {
        a[leftIndex++] = tempArray[t++];
    }
}

//快速排序
- (void)quickSort:(int *)a beginIndex:(int)beginIndex endIndex:(int)endIndex {
    if (beginIndex < endIndex) {
        int midIndex = [self getMidIndex:a beginIndex:beginIndex endIndex:endIndex];
        [self quickSort:a beginIndex:beginIndex endIndex:midIndex-1];
        [self quickSort:a beginIndex:midIndex+1 endIndex:endIndex];
    }
}

- (int)getMidIndex:(int *)a beginIndex:(int)beginIndex endIndex:(int)endIndex {
    int i = beginIndex;
    int j = endIndex;
    int beginValue = a[beginIndex];
    while (i < j) {
        while (a[j] >= beginValue && i < j) {
            j--;
        }
        int temp = a[i];
        a[i] = a[j];
        a[j] = temp;
        
        while (a[i] <= beginValue  && i < j) {
            i++;
        }
        temp = a[j];
        a[j] = a[i];
        a[i] = temp;
    }
    return i;
}

- (void)printArray:(int *)a length:(int)length {
    for (int num = 0; num < length; ++num) {
        NSLog(@"--%d--", a[num]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
