#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

#include "file.h"

int find_event(FILE *fd, fpos_t *prof_start, char *locator)
{
  int flag = 0;
  int found = 0;
  char *buffer = NULL;

  buffer = malloc(strlen(locator)+1);
  if (buffer == NULL)
  {
    perror("memory error");
    goto fail;
  }
  memset(buffer, 0, strlen(locator));
  // Prepares check based on user input profile selection
  // Iterates through file and exits when it has found the start of the profile
  buffer[strlen(locator)] = '\0';
  do
  {
    buffer[flag] = fgetc(fd);
    if (buffer[flag] == locator[flag])
    {
      if (flag == strlen(locator)-1) {
        found++;
      } else {
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

  free(buffer);
  return 0;

fail:
  free(buffer);
  return -1;
}

int parse(char *line, int flag, FILE *file, data *data, labels *labels)
{
  // Variables
  int ret = 0;
  int i = 0;
  char **trimmed = NULL;

  if (line == NULL)
    return 1;

  //printf("line: \"%s\"\n", line);

  ret = trim(line, &trimmed);
  if (ret != 0)
    goto fail;

/*  while(trimmed[i] != NULL) {
    printf("Segment: \"%s\"\n", trimmed[i]);
    i++;
  }*/

fail:
  if (trimmed)
    free (trimmed);
  return ret;
}

int trim(char *line, char ***trimmed)
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
  ret = semitrim(line, &semitrimmed, &decr);
  if (ret != 0)
    goto fail;

  //printf("semitrimmed: \"%s\"\n", semitrimmed);

  // Return number of spaces of semitrimmed line
  for (i = 0; i<strlen(semitrimmed); i++) {
    if (semitrimmed[i] == ' ') {
      count++;
      last = i;
    }
  }

  if (count != 0) {
    if (semitrimmed[last+1] != '\0')
      count++;
  } else if (count == 0)
    count++;

  //printf("Interal count: %d\n", count);

  // Allocate string array
  *trimmed = (char **)malloc((count+1)*sizeof(char *));
  if (trimmed == NULL) {
    perror("memory error");
    ret = -1;
    goto fail;
  }
  for (i = 0; i<count; i++){
    (*trimmed)[i] = (char *)malloc(32+1);
    if ((*trimmed)[i] == NULL) {
      perror("memory error");
      ret = -1;
      goto fail;
    }
    memset((*trimmed)[i],0,32);
  }
  (*trimmed)[count] = NULL;
  int jump;
  // Go through and get each continuous set of characters
  for (int j = 0; j<count; j++) {
    // Number of characters to read
    jump = strcspn((semitrimmed) + offset, ", \0");
    //printf("jump: %d\n", jump);
    // Copy to trimmed each unique "word"
    //printf("semitrimmed+offset: \"%s\"\n", (semitrimmed) + offset);
    if (((semitrimmed) + offset)[0] != '\0') {
      //(*trimmed)[j][index+1] = '\0';
      strncpy((*trimmed)[j], (semitrimmed) + offset, jump);
    }
    // Offset by size of grabbed "word"
    //printf("Semitrimmed[offset+jump]: '%c'\n", semitrimmed[offset+jump]);
    //printf("Offset: %d\n", offset);
    //printf("Trimmed: \"%s\"\n", (*trimmed)[j]);
    len = strlen((*trimmed)[j]);
    if (semitrimmed[jump+offset] == ' ')
      offset = offset + len + 1;
    else
      offset = offset + len + 2;
  }

fail:
  if (semitrimmed)
    free (semitrimmed -= decr);
  return ret;
}

int semitrim(char *line, char **semitrimmed, int *count)
{
  int ret = 0;

  size_t size = strcspn(line,"\n#");

  (*semitrimmed) = malloc((size+1)*sizeof(char));
  if (semitrimmed == NULL) {
    perror("memory error");
    ret = -1;
    goto fail;
  }

  line[size] = '\0';

  //printf("Size: %I64d\n", size);
  //printf("Line appended: \"%s\"\n", line);
  strncpy((*semitrimmed), line, size+1);

  if (size == 0) {
    ret = -1;
    goto fail;
  }

  // Turn all tabs and otherwise into spaces
  for (int i = 0; i < size; i++) {
    if (isspace((*semitrimmed)[i])) {
      (*semitrimmed)[i] = ' ';
    }
  }

  // Remove whitespace on ends
  while(isspace((*semitrimmed)[0])) {
    (*semitrimmed)++;
    (*count)++;
  }

  if ((*semitrimmed)[0] == '\0') {
    ret = -1;
    goto fail;
  }
  //printf("last elem: '%c'\n", (*semitrimmed)[size-2]);
  while (isspace((*semitrimmed)[size-2])) {
    (*semitrimmed)[size-2] = '\0';
    size--;
    //printf("trimming: \"%s\"\n", (*semitrimmed));
  }
  
fail:
  return ret;
}

char *reg_lookup(char* name){
  char *reg = NULL;
  reg = malloc(5*sizeof(char));

  if (strcmp(name, "zero") == 0) reg = zero;
  else if (strcmp(name, "at") == 0) reg = at;
  else if (strcmp(name, "v0") == 0) reg = v0;
  else if (strcmp(name, "v1") == 0) reg = v1;
  else if (strcmp(name, "a0") == 0) reg = a0;
  else if (strcmp(name, "a1") == 0) reg = a1;
  else if (strcmp(name, "a2") == 0) reg = a2;
  else if (strcmp(name, "a3") == 0) reg = a3;
  else if (strcmp(name, "t0") == 0) reg = t0;
  else if (strcmp(name, "t1") == 0) reg = t1;
  else if (strcmp(name, "t2") == 0) reg = t2;
  else if (strcmp(name, "t3") == 0) reg = t3;
  else if (strcmp(name, "t4") == 0) reg = t4;
  else if (strcmp(name, "t5") == 0) reg = t5;
  else if (strcmp(name, "t6") == 0) reg = t6;
  else if (strcmp(name, "t7") == 0) reg = t7;
  else if (strcmp(name, "s0") == 0) reg = s0;
  else if (strcmp(name, "s1") == 0) reg = s1;
  else if (strcmp(name, "s2") == 0) reg = s2;
  else if (strcmp(name, "s3") == 0) reg = s3;
  else if (strcmp(name, "s4") == 0) reg = s4;
  else if (strcmp(name, "s5") == 0) reg = s5;
  else if (strcmp(name, "s6") == 0) reg = s6;
  else if (strcmp(name, "s7") == 0) reg = s7;
  else if (strcmp(name, "t8") == 0) reg = t8;
  else if (strcmp(name, "t9") == 0) reg = t9;
  else if (strcmp(name, "k0") == 0) reg = k0;
  else if (strcmp(name, "k1") == 0) reg = k1;
  else if (strcmp(name, "gp") == 0) reg = gp;
  else if (strcmp(name, "sp") == 0) reg = sp;
  else if (strcmp(name, "fp") == 0) reg = fp;
  else if (strcmp(name, "ra") == 0) reg = ra;
  else reg = zero;

  return reg;
}