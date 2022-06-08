#ifndef _UTILS_H_
#define _UTILS_H_

#define MEM_CODE "memory error"
#define FILE_CODE "file error"

#define SUCCESS 0
#define BAD_ARGUMENT -1
#define ALLOCATION_ERROR -2
#define THREAD_ERROR -3
#define F_FAIL -4
#define FILE_OPEN -5

//  Memory or file check
#define VALID(check, code, err) \
    if (check == NULL) { \
        fprintf(stderr, "%s: %s\n", code, strerror(errno)); \
        perror(code); \
        ret = err; \
        goto exit; \
    }

#define HANDLE_ERR(check, code) \
    if (check != 0) { \
        fprintf(stderr, "%s: %s\n", code, strerror(errno)); \
        perror(code); \
        ret = THREAD_ERROR; \
        goto exit; \
    }

//  Memory alloc, checking, and allignment
#define MEM(ptr, size, type) \
    ptr = malloc(size*sizeof(type)); \
    VALID(ptr, MEM_CODE, ALLOCATION_ERROR); \
    memset(ptr, 0, size*sizeof(type));

//  Return condition check
#define CHECK(ret) \
    if (ret < 0) \
        goto exit;

#define CCHECK(c, s, v, err) \
    if (c s v) \
        ret = err; \
        goto exit;

#endif // _UTILS_H_