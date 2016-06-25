//
//  main.c
//  GLCDemos
//
//  Created by schiller on 16/6/24.
//  Copyright © 2016年 schiller. All rights reserved.
//

#include <stdio.h>
#include "GLStringfile.h"

void swap(int *, int *);
void testStruct();
void getNumer ();
void getFile();
void structType();

int main(int argc, const char * argv[]) {
    printf("Hello, World!\n");
    
//    testAverage();
//
//    bubbleSort();
//    
//    testPointer();
//    
//    int first = 90;
//    int second = 89;
//    swap(&first, &second);

//    testStruct();

//    getNumer();
    
//    getFile();
    structType();
    return 0;
}

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void testStruct() {
    struct Student {
        char studentId;
        char name;
        int age;
        double score;
    };
    
    struct Student stuA, stuB;
    stuA.age = 10;
    stuA.name = 'c';
    stuA.score = 900.0;
    stuA.studentId = 't';
    printf("%d\n", (stuA.studentId));
    return;
}

void getNumer () {
    int number = 7;
    while (1) {
        if (number % 2 == 1 && number % 3 == 2 && number % 5 == 4 && number % 6 == 5 && number % 7 == 0) {
            printf("阶梯一共有%d阶", number);
            break;
        }
        number++;
    }
    return;
}

void getFile() {
    FILE *fp;
    if ((fp = fopen("/Users/schiller/Desktop/test", "at+")) == NULL) {
        printf("fuck, failed");
    }else {
        printf("ooooooo");
    }
}

void structType() {
    typedef struct Test {
        int x ;
        int y;
        char *name;
    }test, *myTest;
    
    test aStruct;
    aStruct.x = 8;
    aStruct.y = 0;
    aStruct.name = "shitshi";
    printf("......%s", aStruct.name);
    
    printf("\n");
    
    myTest aaa;
    aaa = (struct Test*)malloc(sizeof(struct Test*));
    aaa->name = (char *)malloc(sizeof(char));
    aaa->name = "s000000000000hit";
    printf("%s.....", aaa->name);
}