// Expect: 0x6

int binary_search(int *list, int target, int left, int right);

int main()
{

    int list[] = {-8, -7, 0, 6, 8, 30, 401};
    if (binary_search(list, -8, 0, sizeof(list) / sizeof(list[0])) != 0)
    {
        return 1;
    }

    if (binary_search(list, -7, 0, sizeof(list) / sizeof(list[0])) != 1)
    {
        return 1;
    }

    if (binary_search(list, 0, 0, sizeof(list) / sizeof(list[0])) != 2)
    {
        return 1;
    }

    if (binary_search(list, 6, 0, sizeof(list) / sizeof(list[0])) != 3)
    {
        return 1;
    }

    if (binary_search(list, 8, 0, sizeof(list) / sizeof(list[0])) != 4)
    {
        return 1;
    }

    if (binary_search(list, 30, 0, sizeof(list) / sizeof(list[0])) != 5)
    {
        return 1;
    }

    if (binary_search(list, -1, 0, sizeof(list) / sizeof(list[0])) != -1)
    {
        return 1;
    }

    return binary_search(list, 401, 0, sizeof(list) / sizeof(list[0]));
}

int binary_search(int *list, int target, int left, int right)
{
    if (left > right)
    {
        return -1;
    }

    int midpoint = (left + right) / 2;

    if (list[midpoint] == target)
    {
        return midpoint;
    }

    if (list[midpoint] > target)
    {
        return binary_search(list, target, left, midpoint - 1);
    }

    return binary_search(list, target, midpoint + 1, right);
}