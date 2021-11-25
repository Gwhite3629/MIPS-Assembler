#ifndef _FILE_H_
#define _FILE_H_

#include <stdio.h>

// Each value in data memory, name and data address
typedef struct datum {
    char *name;
    int address;
} datum;

// Array of values in data memory
typedef struct data {
     datum *datum;
     int num;
} data;

// Each label in instruction memory, name and label address
typedef struct label {
    char *name;
    int address;
} label;

// Array of labels in instruction memory
typedef struct labels{
    label *label;
    int num;
} labels;

// Finds the occurence in a file of string locator
// Use char_start as location of end of string
// Returns 0 on success
int find_event(FILE *fd, fpos_t *char_start, char *locator);

// Writes to file
// Accepts input line
// Writes to either data or instruction based on flag
// Returns 1 when section set by flag ends
// Returns a negative number on error, 0 on unfinished
int parse(char *line, int flag, FILE *file, data *data, labels *labels);

// Return array of continuous non-whitespace strings from string into trimmed
// Essentially find words
// Returns 0 on success
int trim(char *line, char ***trimmed);

// Returns string without commented text into semitrimmed
// Comments in this case are anything after a '#'
// Returns 0 on success
int semitrim(char *line, char **semitrimmed, int *count);

char *reg_lookup(char *name);

#define zero "00000"
#define at "00001"
#define v0 "00010"
#define v1 "00011"
#define a0 "00100"
#define a1 "00101"
#define a2 "00110"
#define a3 "00111"
#define t0 "01000"
#define t1 "01001"
#define t2 "01010"
#define t3 "01011"
#define t4 "01100"
#define t5 "01101"
#define t6 "01110"
#define t7 "01111"
#define s0 "10000"
#define s1 "10001"
#define s2 "10010"
#define s3 "10011"
#define s4 "10100"
#define s5 "10101"
#define s6 "10110"
#define s7 "10111"
#define t8 "11000"
#define t9 "11001"
#define k0 "11010"
#define k1 "11011"
#define gp "11100"
#define sp "11101"
#define fp "11110"
#define ra "11111"

#endif // _FILE_H_