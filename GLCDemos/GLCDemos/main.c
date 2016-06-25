//
//  main.c
//  GLCDemos
//
//  Created by schiller on 16/6/24.
//  Copyright © 2016年 schiller. All rights reserved.
//

#include <stdio.h>
#include "GLStringfile.h"

void bubbleSort() {
    int array[6] = {4, 0, 5, 6, 8, 2};
    int sum = 0;
    for (int i =0; i<6; i++) {
        int flag = 0;
        for (int j =0; j < 6-i-1; j++) {
            if (array[j] > array[j+1]) {
                flag = 1;
                int temp = array[i];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
            sum ++;
        }
        if (flag ==0) {
            break;
        }
    }
    
    for (int i = 0; i< 5; i ++) {
        printf("%d", array[i]);
    }
    return;
}

int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    
    for (int i =1; i <= 9; i++) {
        for (int j = 1; j <= i; j++) {
            printf("%d * %d = %d\t", j, i, i * j);
        }
        printf("\n");
    }
    
    int scores[6] = {1, 3, 4, 5, 6, 7};
    int sum = 0;
    for (int i = 0; i < 6; i++) {
        sum += scores[i];
    }
    printf("总分 = %d , 平均分=%lf", sum, sum / 6.0);
    
    bubbleSort();
    
    return 0;
}
