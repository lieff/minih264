#pragma once
#ifndef __LGE_SYSTEM_H__
#define __LGE_SYSTEM_H__

#ifdef _WIN32

#include <windows.h>
typedef DWORD THREAD_RET;
#define THRAPI __stdcall
#include <stdint.h>

#else  //_WIN32

#include <stdint.h>
#include <pthread.h>

typedef void * THREAD_RET;
typedef THREAD_RET (*PTHREAD_START_ROUTINE)(void *lpThreadParameter);
typedef PTHREAD_START_ROUTINE LPTHREAD_START_ROUTINE;

typedef pthread_mutex_t CRITICAL_SECTION, *PCRITICAL_SECTION, *LPCRITICAL_SECTION;

#define THRAPI

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

typedef void * HANDLE;
#define MAXIMUM_WAIT_OBJECTS 64
#define INFINITE       (uint32_t)(-1)
#define WAIT_FAILED    (-1)
#define WAIT_TIMEOUT   0x102
#define WAIT_OBJECT    0
#define WAIT_OBJECT_0  0
#define WAIT_ABANDONED   128
#define WAIT_ABANDONED_0 128

#endif //_WIN32

#ifdef __cplusplus
extern "C" {
#else
#ifndef bool
#define bool int
#endif
#endif

HANDLE event_create(bool manualReset, bool initialState);
bool event_destroy(HANDLE event);

#ifndef _WIN32
#define SetEvent event_set
#define ResetEvent event_reset
#define WaitForSingleObject event_wait
#define WaitForMultipleObjects event_wait_multiple
bool event_set(HANDLE event);
bool event_reset(HANDLE event);
int event_wait(HANDLE event, uint32_t milliseconds);
int event_wait_multiple(uint32_t count, const HANDLE *events, bool waitAll, uint32_t milliseconds);
bool InitializeCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
bool DeleteCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
bool EnterCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
bool LeaveCriticalSection(LPCRITICAL_SECTION lpCriticalSection);
#else
#define event_set SetEvent
#define event_reset ResetEvent
#define event_wait WaitForSingleObject
#define event_wait_multiple WaitForMultipleObjects
#endif

HANDLE thread_create(LPTHREAD_START_ROUTINE lpStartAddress, void *lpParameter);
bool thread_close(HANDLE thread);
void *thread_wait(HANDLE thread);
bool thread_name(const char *name);
void thread_sleep(uint32_t milliseconds);

uint64_t GetTime();

#ifdef __cplusplus
}
#endif

#endif //__LGE_SYSTEM_H__
