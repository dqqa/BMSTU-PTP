#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <x86gprintrin.h>

#ifndef SORT
#error SORT not defined
#endif

#ifndef SIZE
#error SIZE not defined
#endif

#ifndef TICKS
#error TICKS not defined
#endif

#define ERR_OK 0

// Функция для перестановки двух чисел
// Принимает два указателя на целое типа int
void swap(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

// Сортировка при помощи индексации a[i]
void bubble_sort_1(int *arr, size_t size)
{
    for (size_t i = 0; i < size - 1; i++)
    {
        for (size_t j = 0; j < size - i - 1; j++)
        {
            if (arr[j] > arr[j + 1])
                swap(&arr[j], &arr[j + 1]);
        }
    }
}

// Сортировка при помощи индексации *(a+i)
void bubble_sort_2(int *arr, size_t size)
{
    for (size_t i = 0; i < size - 1; i++)
    {
        for (size_t j = 0; j < size - i - 1; j++)
        {
            if (*(arr + j) > *(arr + j + 1))
                swap(arr + i, arr + j);
        }
    }
}

// Сортировка при помощи указателей
void bubble_sort_3(int *arr, size_t size)
{
    for (int *pi = arr; pi < arr + size - 1; pi++)
    {
        for (int *pj = arr; pj < arr + size - (pi - arr) - 1; pj++)
        {
            if (*pj > *(pj + 1))
                swap(pj, pj + 1);
        }
    }
}

// Функция для заполнения массива случайными числами
void fill_arr(int *arr, size_t size)
{
    for (size_t i = 0; i < size; i++)
        arr[i] = rand();
}

int main(void)
{
    struct timespec start_time, end_time;

    int arr[SIZE];

    srand(time(NULL));

    fill_arr(arr, SIZE);

#if TICKS == 1
    unsigned long long start_tick = __rdtsc();
#else
    clock_gettime(CLOCK_MONOTONIC_RAW, &start_time);
#endif

    SORT(arr, SIZE);

#if TICKS == 1
    unsigned long long end_tick = __rdtsc();
#else
    clock_gettime(CLOCK_MONOTONIC_RAW, &end_time);
#endif

#if TICKS == 1
    printf("%llu\n", end_tick - start_tick);
#else
    double t_i = (end_time.tv_sec - start_time.tv_sec) * 1e9 + (end_time.tv_nsec - start_time.tv_nsec);
    printf("%f\n", t_i);
#endif

    return ERR_OK;
}
