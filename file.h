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

#endif // _FILE_H_