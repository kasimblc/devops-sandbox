def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b != 0:
        return a / b
    else:
        return "Bölme hatası: Sıfıra bölme!"

def main():
    print("Basit Hesap Makinesi")
    print("İşlemler:")
    print("1. Toplama")
    print("2. Çıkarma")
    print("3. Çarpma")
    print("4. Bölme")

    choice = input("İşlem seçin (1/2/3/4): ")

    num1 = float(input("Birinci sayıyı girin: "))
    num2 = float(input("İkinci sayıyı girin: "))

    if choice == '1':
        print(f"Sonuç: {num1} + {num2} = {add(num1, num2)}")
    elif choice == '2':
        print(f"Sonuç: {num1} - {num2} = {subtract(num1, num2)}")
    elif choice == '3':
        print(f"Sonuç: {num1} * {num2} = {multiply(num1, num2)}")
    elif choice == '4':
        print(f"Sonuç: {num1} / {num2} = {divide(num1, num2)}")
    else:
        print("Geçersiz seçim!")

if __name__ == "__main__":
    main()
