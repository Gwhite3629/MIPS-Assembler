#ifndef _FILE_H_
#define _FILE_H_

#include <stdio.h>
#include <stdbool.h>

// Each value in data memory, name and data address

typedef struct datum {
    char name[64];
    int address;
} datum;

typedef struct data {
    datum data[64];
    int num;
} data;

// Each label in instruction memory, name and label address
typedef struct label {
    char name[64];
    int address;
} label;

typedef struct labels {
    label labels[128];
    int num;
} labels;

typedef struct pair {
    char *key;
    int val;
} pair;

typedef struct dat {
    int val;
    int type;
} dat;

typedef struct triplet {
    char *key;
    dat data;
} triplet;

// Finds the occurence in a file of string locator
// Use char_start as location of end of string
// Returns 0 on success
int find_event(FILE *fd, fpos_t *char_start, char *locator);

// Writes to file
// Accepts input line
// Writes to either data or instruction based on flag
// Returns 1 when section set by flag ends
// Returns a negative number on error, 0 on unfinished
int parse(char *line, int line_num, int flag, FILE *file, int *data_num, labels *labels);

// Return array of continuous non-whitespace strings from string into trimmed
// Essentially find words
// Returns 0 on success
int trim(char *line, int line_num, int flag, labels *labels, int *data_num, char ***trimmed);

// Returns string without commented text into semitrimmed
// Comments in this case are anything after a '#'
// Returns 0 on success
int semitrim(char *line, char **semitrimmed, int *count);

int get_value_pair(char *key, pair *table);

dat get_value_triplet(char *key);

int handle_data(char *trimmed, FILE *file, int *data_num);

int handle_instruction(char *trimmed, FILE *file, labels *labels, int i);

// Instruction type
#define R 0
#define I 1
#define J 2

/*
// Register definitions
pair reg[32] = {{"zero", "00000"},  {"at", "00001"},{"v0", "00010"},{"v1", "00011"},
                {"a0", "00100"},    {"a1", "00101"},{"a2", "00110"},{"a3", "00111"},
                {"t0", "01000"},    {"t1", "01001"},{"t2", "01010"},{"t3", "01011"},
                {"t4", "01100"},    {"t5", "01101"},{"t6", "01110"},{"t7", "0111"},
                {"s0", "10000"},    {"s1", "10001"},{"s2", "10010"},{"s3", "10011"},
                {"s4", "10100"},    {"s5", "10101"},{"s6", "10110"},{"s7", "10111"},
                {"t8", "11000"},    {"t9", "11001"},{"k0", "11010"},{"k1", "11011"},
                {"gp", "11100"},    {"sp", "11101"},{"fp", "11110"},{"ra", "11111"}};

// OP code definitions
pair opcode[32] = {{"R-type", "000000"},{"bltz", "000001"}, {"j", "000010"},    {"jal", "000011"},
                   {"beq", "000100"},   {"bne", "000101"},  {"blez", "000110"}, {"bgtz", "000111"},
                   {"addi", "001000"},  {"addiu", "001001"},{"slti", "001010"}, {"sltiu", "001011"},
                   {"andi", "001100"},  {"ori", "001101"},  {"xori", "001110"}, {"lui", "001111"},
                   {"lb", "100000"},    {"lh", "100001"},   {"lwl", "100010"},  {"lw", "100011"},
                   {"lbu", "100100"},   {"lhu", "100101"},  {"lwr", "100110"},  {"sb", "101000"},
                   {"sh", "101001"},    {"swl", "101010"},  {"sw", "101011"},   {"swr", "101110"},
                   {"ll", "110000"},    {"lwcl", "110001"}, {"sc", "111000"},   {"swcl", "111001"}};

// Function code definitions
pair func[26] = {{"sll", "000000"}, {"srl", "000010"},  {"sra", "000011"},  {"sllv", "000100"},
                 {"srlv", "000110"},{"srav", "000111"}, {"jr", "001000"},   {"jalr", "001001"},
                 {"mfhi", "010000"},{"mthi", "010001"}, {"mflo", "010010"}, {"mtlo", "010011"},
                 {"mult", "011000"},{"multu", "011001"},{"div", "011010"},  {"divu", "011011"},
                 {"add", "100000"}, {"addu", "100001"}, {"sub", "100010"},  {"subu", "100011"},
                 {"and", "100100"}, {"or", "100101"},   {"xor", "100110"},  {"nor", "100111"},
                 {"slt", "101010"}, {"sltu", "101011"}};
*/

#endif // _FILE_H_