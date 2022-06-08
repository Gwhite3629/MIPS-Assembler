#include "file.h"
#include "utils.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>
#include <errno.h>

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
    MEM(locator, 64, char);

    MEM(buf, 256, char);

    // Set up for data write
    sprintf(locator, ".data\n");
    // Open source file
    char fname[64];
    printf("Type name of file to open:\n");
    scanf("%s",fname);
    VALID((input = fopen(fname, "r")), FILE_CODE, FILE_OPEN);

    // Find .data
    CHECK((ret = find_event(input, mark, locator)));
    // Open data file
    VALID((dat = fopen("dat.txt", "w")), FILE_CODE, FILE_OPEN);

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

    // Setup for label read
    sprintf(locator, ".text\n");
    rewind(input);
    flag  = 1;
    exit = 0;
    line_num = 0;
    // Find .text
    CHECK((ret = find_event(input, mark, locator)));
    // Open instruction file
    VALID((ins = fopen("ins.txt", "w")), FILE_CODE, FILE_OPEN);

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
    sprintf(locator, ".text\n");
    rewind(input);
    flag = 2;
    exit = 0;
    line_num = 0;
    CHECK((ret = find_event(input, mark, locator)));
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

exit:
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