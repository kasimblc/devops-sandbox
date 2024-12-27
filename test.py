def factorial(n):
    """Verilen sayının faktöriyelini hesaplar."""
    if n == 0:
        return 1
    return n * factorial(n - 1)


def main():
    """Ana fonksiyon."""
    number = 5
    result = factorial(number)
    print(f"{number} sayısının faktöriyeli: {result}")


if __name__ == "__main__":
    main()
