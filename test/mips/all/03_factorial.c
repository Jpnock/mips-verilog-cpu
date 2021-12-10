// Expect: 122

int fact(int a);
int outerfact();

int main()
{
    int result = outerfact();
    asm("jr $zero");
    return result;
}

int outerfact()
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
