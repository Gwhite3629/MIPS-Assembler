#include "file.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

int main(void)
{
    // Files and random variables
    FILE *input;
    FILE *ins;
    FILE *dat;
    fpos_t *mark = NULL;
    fpos_t *cur = NULL;
    int ret = 0;
    int exit = 0;
    int flag = 0;
    int line_num = 0;

    // Critical memory
    char *buf = NULL;
    char *locator = NULL;
    int data_num = 0;
    labels labels;
    labels.num = 0;

    // Allocate strings
    locator = malloc(10 * sizeof(char));
    if (locator == NULL)
    {
        perror("memory error");
        ret = -1;
        goto fail;
    }

    buf = malloc(256 * sizeof(char));
    if (buf == NULL)
    {
        perror("memory error");
        ret = -1;
        goto fail;
    }


    // Set up for data write
    locator = ".data\n";
    // Open source file
    char fname[64];
    printf("Type name of file to open:\n");
    scanf("%s",fname);
    input = fopen(fname, "r");
    if (input == NULL)
        goto fail;
    // Find .data
    ret = find_event(input, mark, locator);
    // Open data file
    dat = fopen("dat.txt", "w");
    if (dat == NULL)
        goto fail;
    int skip = 0;
    // Read through data section
    while (exit != 1)
    {
        if (fgets(buf, 256, input) == NULL)
            break;
        if (strcmp(buf, "\t.text\n")==0)
            skip = 1;

        if (!skip) {
            //printf("Buf: \"%s\"\n", buf);
            if (buf[0] != '\n') {
                exit = parse(buf, line_num, flag, dat, &data_num, &labels);
                printf("\n");
                line_num++;
            }
        }
    }
    printf("Exited\n");
    // Close data file
    fclose(dat);


    // Setup for label read
    locator = ".text\n";
    rewind(input);
    flag  = 1;
    exit = 0;
    line_num = 0;
    // Find .text
    ret = find_event(input, mark, locator);
    // Open instruction file
    ins = fopen("ins.txt", "w");
    if (ins == NULL)
        goto fail;
    skip = 0;
    // Read through instruction section
    while (exit != 1)
    {
        if (fgets(buf, 256, input) == NULL)
            break;
        if (strcmp(buf, "\t.data\n")==0)
            skip = 1;

        if (!skip) {
        //printf("Buf: \"%s\"\n", buf);
            if (buf[0] != '\n') {
                exit = parse(buf, line_num, flag, ins, &data_num, &labels);
                printf("\n");
                line_num++;
            }
        }
    }

    // Write actual instructions
    locator = ".text\n";
    rewind(input);
    flag = 2;
    exit = 0;
    line_num = 0;
    ret = find_event(input, mark, locator);
    skip = 0;
    while (exit != 1) {
        if (fgets(buf, 256, input) == NULL)
            break;
        if(strcmp(buf, "\t.data\n")==0)
            skip = 1;

        if (!skip) {
            if (buf[0] != '\n') {
                exit = parse(buf, line_num, flag, ins, &data_num, &labels);
                printf("\n");
                line_num++;
            }
        }
    }

    for (int j = 0;j<labels.num;j++) {
        printf("Labels: %s, Address: %d\n", labels.labels[j].name, labels.labels[j].address);
    }

fail:
    // Check memory and files and free or close
    if (locator)
        free(locator);
    if (input)
        fclose(input);
    if (dat)
        fclose(dat);
    if (ins)
        fclose(ins);
    for (int j = 0;j<128;j++) {
        if (labels.labels[j].name)
            free(labels.labels[j].name);
    }
    // Return appropriate error, errors defined in file.h
    return ret;
}