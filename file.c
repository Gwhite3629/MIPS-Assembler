#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <stdbool.h>
#include <errno.h>

#include "file.h"
#include "utils.h"

int find_event(FILE *fd, fpos_t *prof_start, char *locator)
{
  int ret = 0;
  int flag = 0;
  int found = 0;
  char *buffer = NULL;

  MEM(buffer, (strlen(locator)+1), char);
  // Prepares check based on user input profile selection
  // Iterates through file and exits when it has found the start of the profile
  buffer[strlen(locator)] = '\0';
  do
  {
    buffer[flag] = fgetc(fd);
    if (buffer[flag] == locator[flag])
    {
      if (flag == strlen(locator) - 1)
      {
        found++;
      }
      else
      {
        flag++;
      }
    }
    else
    {
      flag = 0;
    }
    // if (flag > 0)
    // printf("buffer[flag]: %c, locator[flag]: %c, strlen(locator): %I64d, flag: %d, found: %d\n", buffer[flag], locator[flag], strlen(locator), flag, found);
  } while (found < 1);

exit:
  if (buffer)
    free(buffer);
  return ret;
}

int parse(char *line, int line_num, int flag, FILE *file, int *data_num, labels *labels)
{
  // Variables
  int ret = 0;
  int i = 0;
  char **trimmed = NULL;

  CCHECK(line, ==, NULL, SUCCESS)

  for (int j = 0; j < 128; j++)
  {
    MEM(labels->labels[j].name, 64, sizeof(char));
  }

  // printf("line: \"%s\"\n", line);

  CHECK((ret = trim(line, line_num, flag, labels, data_num, &trimmed)));

  // Count words
  while (trimmed[i] != NULL)
  {
    printf("Segment: \"%s\"\n", trimmed[i]);
    i++;
  }
  i--;
  switch (flag)
  {
  case 0:
    handle_data(trimmed, file, data_num);
    break;
  case 1:
    break;
  case 2:
    printf("instruction\n");
    handle_instruction(trimmed, file, labels, i);
    break;
  }

exit:
  for (int j = i - 1; j >= 0; j--)
  {
    if (trimmed[j])
      free(trimmed[j]);
  }
  if (trimmed)
    free(trimmed);
  return ret;
}

int trim(char *line, int line_num, int flag, labels *labels, int *data_num, char ***trimmed)
{
  // Variables
  int decr = 0;
  int ret = 0;
  int i;
  int count = 0;
  int last;
  int offset = 0;
  int len = 0;
  char *semitrimmed = NULL;

  // Semitrim, remove comments
  CHECK((ret = semitrim(line, &semitrimmed, &decr)));

  int size = strcspn(semitrimmed, ":");
  if (size != strlen(semitrimmed))
  {
    printf("Size: %d\n", size);
    strncpy(labels->labels[(*labels).num].name, line, size);
    switch (flag)
    {
    case 0:
      labels->labels[(*labels).num].address = *data_num;
      labels->num++;
      break;
    case 1:
      labels->labels[(*labels).num].address = line_num;
      labels->num++;
      break;
    case 2:
      break;
    }
  }
  // printf("semitrimmed: \"%s\"\n", semitrimmed);

  // Return number of spaces of semitrimmed line
  for (i = 0; i < strlen(semitrimmed); i++)
  {
    if (semitrimmed[i] == ' ')
    {
      count++;
      last = i;
    }
  }

  if (count != 0)
  {
    if (semitrimmed[last + 1] != '\0')
      count++;
  }
  else if (count == 0)
    count++;

  // printf("Interal count: %d\n", count);

  // Allocate string array
  MEM(*trimmed,(count + 1), char *);

  for (i = 0; i < count; i++)
  {
    MEM((*trimmed)[i], 33, char);
  }
  (*trimmed)[count] = NULL;
  int jump;
  // Go through and get each continuous set of characters
  for (int j = 0; j < count; j++)
  {
    // Number of characters to read
    jump = strcspn((semitrimmed) + offset, ", \0");
    // printf("jump: %d\n", jump);
    //  Copy to trimmed each unique "word"
    // printf("semitrimmed+offset: \"%s\"\n", (semitrimmed) + offset);
    if (((semitrimmed) + offset)[0] != '\0')
    {
      //(*trimmed)[j][index+1] = '\0';
      strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
    }
    // Offset by size of grabbed "word"
    // printf("Semitrimmed[offset+jump]: '%c'\n", semitrimmed[offset+jump]);
    // printf("Offset: %d\n", offset);
    // printf("Trimmed: \"%s\"\n", (*trimmed)[j]);
    len = strlen((*trimmed)[j]);
    if (semitrimmed[jump + offset] == ' ')
      offset = offset + len + 1;
    else
      offset = offset + len + 2;
  }

exit:
  if (semitrimmed)
    free(semitrimmed -= decr);
  return ret;
}

int semitrim(char *line, char **semitrimmed, int *count)
{
  int ret = 0;

  size_t size = strcspn(line, "\n#");

  MEM((*semitrimmed), (size + 1), char)

  line[size] = '\0';

  // printf("Size: %I64d\n", size);
  // printf("Line appended: \"%s\"\n", line);
  strncpy((*semitrimmed), line, size + 1);

  CCHECK(size, ==, 0, F_FAIL)

  // Turn all tabs and otherwise into spaces
  for (int i = 0; i < size; i++)
  {
    if (isspace((*semitrimmed)[i]))
    {
      (*semitrimmed)[i] = ' ';
    }
  }

  // Remove whitespace on ends
  while (isspace((*semitrimmed)[0]))
  {
    (*semitrimmed)++;
    (*count)++;
  }

  CCHECK((*semitrimmed)[0], ==, '\0', F_FAIL)

  // printf("last elem: '%c'\n", (*semitrimmed)[size-2]);
  while (isspace((*semitrimmed)[size - 2]))
  {
    (*semitrimmed)[size - 2] = '\0';
    size--;
    // printf("trimming: \"%s\"\n", (*semitrimmed));
  }

exit:
  return ret;
}

// Register definitions
pair reg[32] = {{"zero", 0}, {"at", 1}, {"v0", 2}, {"v1", 3}, {"a0", 4}, {"a1", 5}, {"a2", 6}, {"a3", 7}, {"t0", 8}, {"t1", 9}, {"t2", 10}, {"t3", 11}, {"t4", 12}, {"t5", 13}, {"t6", 14}, {"t7", 15}, {"s0", 16}, {"s1", 17}, {"s2", 18}, {"s3", 19}, {"s4", 20}, {"s5", 21}, {"s6", 22}, {"s7", 23}, {"t8", 24}, {"t9", 25}, {"k0", 26}, {"k1", 27}, {"gp", 28}, {"sp", 29}, {"fp", 30}, {"ra", 31}};

// OP code definitions
triplet opcode[43] = {{"add", {0, R}}, {"addu", {0, R}}, {"and", {0, R}}, {"jr", {0, R}}, {"nor", {0, R}}, {"or", {0, R}}, {"bltz", {1, I}}, {"j", {2, J}}, {"jal", {3, J}}, {"slt", {0, R}}, {"sltu", {0, R}}, {"sll", {0, R}}, {"srl", {0, R}}, {"sub", {0, R}}, {"subu", {0, R}}, {"beq", {4, I}}, {"bne", {5, I}}, {"blez", {6, I}}, {"bgtz", {7, I}}, {"addi", {8, I}}, {"addiu", {9, I}}, {"slti", {10, I}}, {"sltiu", {11, I}}, {"andi", {12, I}}, {"ori", {13, I}}, {"xori", {14, I}}, {"lui", {15, I}}, {"lb", {16, I}}, {"lh", {17, I}}, {"lwl", {18, I}}, {"lw", {19, I}}, {"lbu", {20, I}}, {"lhu", {21, I}}, {"lwr", {22, I}}, {"sb", {23, I}}, {"sh", {24, I}}, {"swl", {25, I}}, {"sw", {26, I}}, {"swr", {27, I}}, {"ll", {28, I}}, {"lwcl", {29, I}}, {"sc", {30, I}}, {"swcl", {31, I}}};

// Function code definitions
pair funct[26] = {{"sll", 0}, {"srl", 2}, {"sra", 3}, {"sllv", 4}, {"srlv", 6}, {"srav", 7}, {"jr", 8}, {"jalr", 9}, {"mfhi", 16}, {"mthi", 17}, {"mflo", 18}, {"mtlo", 19}, {"mult", 24}, {"multu", 25}, {"div", 26}, {"divu", 27}, {"add", 32}, {"addu", 33}, {"sub", 34}, {"subu", 35}, {"and", 36}, {"or", 37}, {"xor", 38}, {"nor", 39}, {"slt", 42}, {"sltu", 43}};

pair pseudo[8] = {{"move", 0}, {"li", 1}, {"la", 2}, {"blt", 3}, {"ble", 4}, {"bgt", 5}, {"bge", 6}, {"b", 9}};

static int compare_keys_pair(const void *va, const void *vb)
{
  const pair *a = va, *b = vb;
  return strcmp(a->key, b->key);
}

static int compare_keys_triplet(const void *va, const void *vb)
{
  const triplet *a = va, *b = vb;
  return strcmp(a->key, b->key);
}

static int compare_keys_label(const void *va, const void *vb)
{
  const label *a = va, *b = vb;
  return strcmp(a->name, b->name);
}

int get_value_pair(char *key, pair *table)
{
  pair key_pair[1] = {{key}};
  qsort(table, sizeof table / sizeof table[0], sizeof table[0], compare_keys_pair);
  pair *p = bsearch(key_pair, table, sizeof table / sizeof table[0], sizeof table[0], compare_keys_pair);
  return p ? p->val : -1;
}

int get_value_labels(char *key, label *labels)
{
  label key_pair[1] = {{key}};
  qsort(labels, sizeof labels / sizeof labels[0], sizeof labels[0], compare_keys_label);
  label *l = bsearch(key_pair, labels, sizeof labels / sizeof labels[0], sizeof labels[0], compare_keys_label);
  return l ? l->address : -1;
}

dat get_value_triplet(char *key)
{
  dat r = {-1, -1};
  triplet key_pair[1] = {{key}};
  qsort(opcode, sizeof opcode / sizeof opcode[0], sizeof opcode[0], compare_keys_triplet);
  triplet *t = bsearch(key_pair, opcode, sizeof opcode / sizeof opcode[0], sizeof opcode[0], compare_keys_triplet);
  return t ? t->data : r;
}

int handle_data(char **trimmed, FILE *file, int *data_num)
{
  int i = 0;
  while (trimmed[i] != NULL)
  {
    if (strcspn(trimmed[i], "0123456789") != strlen(trimmed[i]))
    {
      (*data_num)++;
      fprintf(file, "%08x\n", strtol(trimmed[i], NULL, 10));
    }
    i++;
  }
  return 0;
}

int handle_instruction(char **trimmed, FILE *file, labels *labels, int i)
{
  int chk = 0;
  int label_addr = 0;
  int rs;
  int rt;
  int rd;
  int shamt;
  int func;
  dat op;
  // Check if line is not just a label
  if (i > 1 & (strcspn(trimmed[0], ":") == strlen(trimmed[0])))
  {
    // Check if opcode is a pseudo-instruction, note: fails on labels
    chk = get_value_pair(trimmed[0], pseudo);
    if (chk != -1)
    {
      switch (chk)
      {
      // move rd rt
      case 0:
        rs = 0;
        rt = get_value_pair(trimmed[2], reg);
        rd = get_value_pair(trimmed[1], reg);
        shamt = 0;
        // addu rd $0 rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (33));
        break;
      // li rd immed
      case 1:
        rt = 0;
        rd = get_value_pair(trimmed[1], reg);
        // ori rd $0 immed
        fprintf(file, "%08x\n", (13 << 26) + (rt << 21) + (rd << 16) + (trimmed[i - 1]));
        break;
      // la rd label
      case 2:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        // LUI $at, 0x10010000
        fprintf(file, "%08x\n", (15 << 26) + (1 << 21) + (268500992));
        rt = 1;
        rd = get_value_pair(trimmed[1], reg);
        // ori rd $at immed
        fprintf(file, "%08x\n", (13 << 26) + (rt << 21) + (rd << 16) + (label_addr));
        break;
      // blt rs rt label
      case 3:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[1], reg);
        rt = get_value_pair(trimmed[2], reg);
        // slt $at rs rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (1 << 11) + (0 << 6) + (42));
        // bne $at $0 label
        fprintf(file, "%08x\n", (5 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // ble rs, rt, label
      case 4:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[1], reg);
        rt = get_value_pair(trimmed[2], reg);
        // slt $at rt rs
        fprintf(file, "%08x\n", (0 << 26) + (rt << 26) + (rs << 16) + (1 << 11) + (0 << 6) + (42));
        // beq $at $0 label
        fprintf(file, "%08x\n", (4 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // bgt rs rt label
      case 5:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[1], reg);
        rt = get_value_pair(trimmed[2], reg);
        // slt $at rt rs
        fprintf(file, "%08x\n", (0 << 26) + (rt << 26) + (rs << 16) + (1 << 11) + (0 << 6) + (42));
        // bne $at $0 label
        fprintf(file, "%08x\n", (5 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // bge rs rt label
      case 6:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[1], reg);
        rt = get_value_pair(trimmed[2], reg);
        // slt $at rs rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (1 << 11) + (0 << 6) + (42));
        // beq $at $0 label
        fprintf(file, "%08x\n", (4 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // b label
      case 7:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        // beq $0 $0 label
        fprintf(file, "%08x\n", (4 << 26) + (0 << 21) + (0 << 21) + (label_addr));
        break;
      }
      // Operates on non-pseudo instructions
    }
    else
    {
      op = get_value_triplet(trimmed[0]);
      // Confirms opcode is valid
      if (op.val != -1)
      {
        // Operates on instructions with labels
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        if (label_addr != -1)
        {
          // Check LW pseudo condition
          if (op.val == 19)
          {
            // LUI $at, 0x10010000
            fprintf(file, "%08x\n", (15 << 26) + (1 << 21) + (268500992));
            rs = get_value_pair(trimmed[2], reg);
            rt = get_value_pair(trimmed[1], reg);
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
            // Check branches with numeric comparisons
          }
          else if ((op.val == 4 && (get_value_pair(trimmed[2], reg) == -1)) || (op.val == 5 && (get_value_pair(trimmed[2], reg) == -1)))
          {
            // add $at $0 val
            rd = 1;
            rs = 0;
            rt = strtol(trimmed[2], NULL, 10);
            shamt = 0;
            func = 32;
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (func));
            // B(eq,ne) rs $at label
            rs = get_value_pair(trimmed[1], reg);
            rt = 1;
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
          }
          else
          {
            switch (op.val)
            {
            case 1:
              rs = get_value_pair(trimmed[2], reg);
              rt = get_value_pair(trimmed[1], reg);
              fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
              break;
            case 2:
              fprintf(file, "%08x\n", (op.val << 26) + (label_addr));
              break;
            }
          }
          // Operate on non-label instructions
        }
        else
        {
          switch (op.type)
          {
          // R-type
          case 0:
            break;
            func = get_value_pair(trimmed[0], funct);
            switch (func)
            {
            case (0 | 2 | 3 | 4 | 6 | 7):
              rs = 0;
              rt = get_value_pair(trimmed[2], reg);
              rd = get_value_pair(trimmed[1], reg);
              shamt = strtol(trimmed[i - 1], NULL, 10);
              break;
            case (8):
              rs = get_value_pair(trimmed[1], reg);
              rt = 0;
              rd = 0;
              shamt = 0;
              break;
            case (9):
              rs = get_value_pair(trimmed[2], reg);
              rt = 0;
              rd = get_value_pair(trimmed[1], reg);
              shamt = 0;
              break;
            case (32 | 33 | 34 | 35 | 36 | 37 | 38 | 39 | 42 | 43):
              rs = get_value_pair(trimmed[2], reg);
              rt = get_value_pair(trimmed[3], reg);
              rd = get_value_pair(trimmed[1], reg);
              shamt = 0;
              break;
            }
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (func));
          // I-type
          case 1:
            if (op.val == 19 || op.val == 26)
              ;
            rs = get_value_pair(trimmed[2], reg);
            rt = get_value_pair(trimmed[1], reg);
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (trimmed[i - 1]));
            break;
          }
        }
      }
    }
    // If first word of line was a label, opcode is second
  }
  else if (i > 1)
  {
    // Find pseudos
    chk = get_value_pair(trimmed[1], pseudo);
    if (chk != -1)
    {
      switch (chk)
      {
      // move rd rt
      case 0:
        rs = 0;
        rt = get_value_pair(trimmed[3], reg);
        rd = get_value_pair(trimmed[2], reg);
        shamt = 0;
        // addu rd $0 rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (33));
        break;
      // li rd immed
      case 1:
        rt = 0;
        rd = get_value_pair(trimmed[2], reg);
        // ori rd $0 immed
        fprintf(file, "%08x\n", (13 << 26) + (rt << 21) + (rd << 16) + (trimmed[i - 1]));
        break;
      // la rd label
      case 2:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        // LUI $at, 0x10010000
        fprintf(file, "%08x\n", (15 << 26) + (1 << 21) + (268500992));
        rt = 1;
        rd = get_value_pair(trimmed[2], reg);
        // ori rd $at immed
        fprintf(file, "%08x\n", (13 << 26) + (rt << 21) + (rd << 16) + (label_addr));
        break;
      // blt rs rt label
      case 3:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[2], reg);
        rt = get_value_pair(trimmed[3], reg);
        // slt $at rs rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (1 << 11) + (0 << 6) + (42));
        // bne $at $0 label
        fprintf(file, "%08x\n", (5 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // ble rs, rt, label
      case 4:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[2], reg);
        rt = get_value_pair(trimmed[3], reg);
        // slt $at rt rs
        fprintf(file, "%08x\n", (0 << 26) + (rt << 26) + (rs << 16) + (1 << 11) + (0 << 6) + (42));
        // beq $at $0 label
        fprintf(file, "%08x\n", (4 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // bgt rs rt label
      case 5:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[2], reg);
        rt = get_value_pair(trimmed[3], reg);
        // slt $at rt rs
        fprintf(file, "%08x\n", (0 << 26) + (rt << 26) + (rs << 16) + (1 << 11) + (0 << 6) + (42));
        // bne $at $0 label
        fprintf(file, "%08x\n", (5 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // bge rs rt label
      case 6:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        rs = get_value_pair(trimmed[2], reg);
        rt = get_value_pair(trimmed[3], reg);
        // slt $at rs rt
        fprintf(file, "%08x\n", (0 << 26) + (rs << 21) + (rt << 16) + (1 << 11) + (0 << 6) + (42));
        // beq $at $0 label
        fprintf(file, "%08x\n", (4 << 26) + (1 << 21) + (0 << 16) + (label_addr));
        break;
      // b label
      case 7:
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        // beq $0 $0 label
        fprintf(file, "%08x\n", (4 << 26) + (0 << 21) + (0 << 21) + (label_addr));
        break;
      }
      // Operate on non-pseudos
    }
    else
    {
      op = get_value_triplet(trimmed[1]);
      // Check if valid
      if (op.val != -1)
      {
        // Check if label
        label_addr = get_value_labels(trimmed[i - 1], labels->labels);
        if (label_addr != -1)
        {
          // Check LW pseudo condition
          if (op.val == 19)
          {
            // LUI $at, 0x10010000
            fprintf(file, "%08x\n", (15 << 26) + (1 << 21) + (268500992));
            rs = get_value_pair(trimmed[3], reg);
            rt = get_value_pair(trimmed[2], reg);
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
          }
          else if ((op.val == 4 && (get_value_pair(trimmed[3], reg) == -1)) || (op.val == 5 && (get_value_pair(trimmed[3], reg) == -1)))
          {
            // add $at $0 val
            rd = 1;
            rs = 0;
            rt = strtol(trimmed[3], NULL, 10);
            shamt = 0;
            func = 32;
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (func));
            // B(eq,ne) rs $at label
            rs = get_value_pair(trimmed[2], reg);
            rt = 1;
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
          }
          else
          {
            switch (op.val)
            {
            case 1:
              rs = get_value_pair(trimmed[3], reg);
              rt = get_value_pair(trimmed[2], reg);
              fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (label_addr));
              break;
            case 2:
              fprintf(file, "%08x\n", (op.val << 26) + (label_addr));
              break;
            }
          }
          // Operate on non-label
        }
        else
        {
          switch (op.val)
          {
          case 0:
            func = get_value_pair(trimmed[1], funct);
            switch (func)
            {
            case (0 | 2 | 3 | 4 | 6 | 7):
              rs = 0;
              rt = get_value_pair(trimmed[3], reg);
              rd = get_value_pair(trimmed[2], reg);
              shamt = strtol(trimmed[i - 1], NULL, 10);
              break;
            case (8):
              rs = get_value_pair(trimmed[2], reg);
              rt = 0;
              rd = 0;
              shamt = 0;
              break;
            case (9):
              rs = get_value_pair(trimmed[3], reg);
              rt = 0;
              rd = get_value_pair(trimmed[2], reg);
              shamt = 0;
              break;
            case (32 | 33 | 34 | 35 | 36 | 37 | 38 | 39 | 42 | 43):
              rs = get_value_pair(trimmed[3], reg);
              rt = get_value_pair(trimmed[4], reg);
              rd = get_value_pair(trimmed[2], reg);
              shamt = 0;
              break;
            }
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (rd << 11) + (shamt << 6) + (func));
          case 1:
            rs = get_value_pair(trimmed[3], reg);
            rt = get_value_pair(trimmed[2], reg);
            fprintf(file, "%08x\n", (op.val << 26) + (rs << 21) + (rt << 16) + (trimmed[i - 1]));
            break;
          }
        }
      }
    }
  }
  return 0;
}