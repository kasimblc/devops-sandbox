# example.py
def greet(name=None):
    if name:
        print(f"Hello, {name}!")
    else:
        print("Hello, World!")

greet("Alice")
greet()
