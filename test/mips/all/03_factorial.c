// Expect: 122

int fact(int a);

int main()
{
    int result = fact(5);
    return result + 2;
}

int fact(int a)
{
    if (a == 0 || a == 1)
    {
        return 1;
    }
    return a * fact(a - 1);
}
