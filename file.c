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