import random

def guess_number():
    number_to_guess = random.randint(1, 100)
    guess = None
    attempts = 0

    print("1 ile 100 arasında bir sayı tuttum. Bakalım tahmin edebilecek misin?")

    while guess != number_to_guess:
        guess = int(input("Tahmininizi girin: "))
        attempts += 1

        if guess < number_to_guess:
            print("Daha büyük bir sayı tahmin edin.")
        elif guess > number_to_guess:
            print("Daha küçük bir sayı tahmin edin.")
        else:
            print(f"Tebrikler! {attempts} denemede doğru tahmini buldunuz.")

if __name__ == "__main__":
    guess_number()
