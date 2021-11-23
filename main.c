#include "file.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    // Files and random variables
    FILE *input;
    FILE *ins;
    FILE *dat;
    fpos_t *mark = NULL;
    fpos_t *cur = NULL;
    int ret = 0;
    int exit = 0;
    int flag;

    // Critical memory
    char *buf = NULL;
    char *locator = NULL;
    data *dat_mem;
    labels *ins_mem;

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
    flag = 0;

    // Open source file
    input = fopen(argv[1], "r");
    if (input == NULL)
        goto fail;

    // Find .data
    ret = find_event(input, mark, locator);

    // Open data file
    dat = fopen("dat.txt", "w");
    if (dat == NULL)
        goto fail;

    // Read through data section
    while (exit != 1)
    {
        if (fgets(buf, 256, input) == NULL)
            break;
        printf("Buf: \"%s\"\n", buf);
        if (buf[0] != '\n')
            exit = parse(buf, flag, dat, dat_mem, ins_mem);
    }

    printf("Exited\n");

    // Close data file
    fclose(dat);

    // Setup for instruction write
    locator = ".text\n";
    rewind(input);
    flag  = 1;
    exit = 0;

    // Find .text
    ret = find_event(input, mark, locator);

    // Open instruction file
    ins = fopen("ins.txt", "w");
    if (ins == NULL)
        goto fail;

    // Read through instruction section
    while (exit != 1)
    {
        if (fgets(buf, 256, input) == NULL)
            break;
        printf("Buf: \"%s\"\n", buf);
        if (buf[0] != '\n')
            exit = parse(buf, flag, ins, dat_mem, ins_mem);
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
    // Return appropriate error, errors defined in file.h
    return ret;
}