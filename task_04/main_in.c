#include <math.h>
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
#define TOO_FEW_ELEMENTS 1

#define MAX_ARR_SIZE 10000
#define MIN_REPEATS 50

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

// Функция для подсчета RSE
int calc_rse(const double *times, size_t size, double *rse)
{
    if (size < 2)
        return TOO_FEW_ELEMENTS;
    double disp = 0, std_err;

    double avg = 0;
    for (size_t i = 0; i < size; i++)
        avg += times[i];

    avg /= size;

    for (size_t i = 0; i < size; i++)
        disp += (times[i] - avg) * (times[i] - avg);

    disp /= size - 1;
    disp = sqrt(disp);

    std_err = disp / sqrt(size);
    *rse = std_err / avg * 100;

    return ERR_OK;
}

int main(void)
{
    struct timespec start_time, end_time;

    int arr[SIZE];
    double times[MAX_ARR_SIZE], rse = -1;

    srand(time(NULL));
    size_t times_size = 0;

    // Прогрев
    fill_arr(arr, SIZE);
    SORT(arr, SIZE);

    // Проводим сортировку, пока RSE > 1%
    while (times_size < MIN_REPEATS || times_size < MAX_ARR_SIZE && (rse < 0 || rse > 1))
    {
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
        double t_i = end_tick - start_tick;
        printf("%f\n", t_i);
#else
        double t_i = (end_time.tv_sec - start_time.tv_sec) * 1e9 + (end_time.tv_nsec - start_time.tv_nsec);
        printf("%f\n", t_i);
#endif

        times[times_size++] = t_i;
        calc_rse(times, times_size, &rse);
    }

    return ERR_OK;
}
