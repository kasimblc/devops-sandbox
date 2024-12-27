# example.py
def greet(name=None):
    if name:
        print(f"Hello, {name}!")
    else:
        print("Hello, World!")

greet("Alice")
greet()

# Yeni eklenen fonksiyonlar
def farewell(name=None):
    if name:
        print(f"Goodbye, {name}!")
    else:
        print("Goodbye, World!")

farewell("Bob")
farewell()

def add(a, b):
    return a + b

print(add(3, 5))
print(add(10, 20))
