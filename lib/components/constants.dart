import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color.fromRGBO(3, 9, 69, 1);
const Color textColor = Colors.white;
const Color iconColor = Colors.white;
const Color secondaryColor = Color(0xFF030945);
const Color backgroundColor = Color(0xFFF5F5F5);
const MaterialColor customColor = MaterialColor(
  0xFF030945,
  <int, Color>{
    50: Color(0xFFE3E6F6),
    100: Color(0xFFC5CBE6),
    200: Color(0xFFA7A0D6),
    300: Color(0xFF8A75C6),
    400: Color(0xFF6C4AB5),
    500: Color(0xFF4E2F9D),
    600: Color(0xFF452A90),
    700: Color(0xFF3B2383),
    800: Color(0xFF311D76),
    900: Color(0xFF261567),
  },
);

final Map<String, String> lessonDetails = {
// Lesson 1

  'Lesson 1: Introduction to Python': '''
Introduction to Python

Python is a high-level, interpreted programming language known for its ease of use and readability. Created by Guido van Rossum and first released in 1991, Python has become one of the most popular programming languages in the world. Its simplicity and versatility make it an excellent choice for both beginners and experienced developers.

Key Features of Python

- Readability: Python's syntax is designed to be easy to read and write, which helps developers create clean and maintainable code.
- Versatility: Python is used across various domains including web development, data analysis, artificial intelligence, and scientific computing.
- Extensive Libraries**: With a rich standard library and a vast ecosystem of third-party libraries, Python simplifies development across different applications.
- Community Support**: Python boasts a large and active community that contributes to an extensive range of resources, frameworks, and tools.

Python's Use Cases

1. Web Development: Python is a popular choice for web development, with frameworks like Django and Flask that simplify building and managing web applications.
2. Data Analysis: Libraries such as Pandas, NumPy, and Matplotlib empower Python users to perform data analysis and create visualizations.
3. Artificial Intelligence**: Python is at the forefront of AI and machine learning, supported by libraries like TensorFlow, Keras, and Scikit-learn.
4. Scientific Computing**: For complex computations and simulations, Python offers numerical and scientific libraries like SciPy.

Python's History

Python was developed by Guido van Rossum, inspired by the ABC programming language. The first version, Python 0.9.0, was released in February 1991. Python has evolved significantly since then, with Python 3.x being the current major version. While Python 2.x is still used in some legacy systems, Python 3.x is recommended for new projects.

Python File Extension

Python source code files use the `.py` extension. This signifies that the file contains Python code and enables the Python interpreter to execute the code when the file is run.

Python's Case Sensitivity

Python is a case-sensitive language, meaning that variable names, function names, and other identifiers are treated differently based on their capitalization. For instance, `Variable` and `variable` are distinct identifiers in Python.

Conclusion

In summary, Python's simplicity, versatility, and extensive support make it an invaluable tool for a wide range of programming tasks. Whether you're developing web applications, analyzing data, or exploring AI, Python equips you with the necessary tools and libraries to succeed.
''',

// Lesson 2

  'Lesson 2: Variables and Data Types': '''
Variables and Data Types

In Python, variables are essential for storing data that can be manipulated and used throughout your code. Understanding how to use variables effectively, along with the different data types available, is crucial for writing efficient Python programs.

Variables

Variables in Python are created by assigning a value to a name. Unlike some other programming languages, Python does not require you to declare the variable type explicitly. The type is inferred from the value assigned.

Example of variable assignment
name = "Alice"    # String
age = 30          # Integer
height = 5.5      # Float
is_student = True # Boolean


Key Points:
- Variables: Created by assigning values, with types inferred from the values.
- Types: Examples include `String`, `Integer`, `Float`, and `Boolean`.

This condensed format keeps the focus on the core concepts and example, ensuring clarity and avoiding excessive detail.''',

// Lessson 3

  'Lesson 3: Conditional Statements': '''

Conditional Statements

Conditional statements are crucial for making decisions in your code by evaluating conditions and executing blocks of code accordingly.

The `if` Statement
Used to execute a block of code if a condition is true.

age = 18
if age >= 18:
    print("You are an adult.")

The else Statement Executes code if the if condition is false.


age = 16
if age >= 18:
    print("You are an adult.")
else:
    print("You are a minor.")

The elif Statement Checks additional conditions if the if condition is false.

age = 20
if age < 13:
    print("You are a child.")
elif age < 18:
    print("You are a teenager.")
else:
    print("You are an adult.")


Nested Conditionals You can nest if statements within each other.

age = 25
if age >= 18:
    if age < 21:
        print("You are an adult, but not old enough to drink alcohol in the US.")
    else:
        print("You are an adult and can drink alcohol.")
else:
    print("You are a minor.")

Conclusion Conditional statements help in making decisions and controlling the flow of your program.
''',

// Lessson 4

  'Lesson 4: Loops in Python': '''

Loops in Python

Loops are essential for executing a block of code repeatedly. Python provides several loop constructs to handle repetitive tasks.

The `for` Loop
Used to iterate over a sequence (like a list, tuple, or string) and execute a block of code for each item.

# Example of a for loop
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)

The while Loop Executes a block of code as long as a condition is true.

# Example of a while loop
count = 0
while count < 5:
    print(count)
    count += 1

Loop Control Statements

break: Exits the loop prematurely.

# Example of break
for num in range(10):
    if num == 5:
        break
    print(num)

continue: Skips the rest of the current iteration and moves to the next one.

# Example of continue
for num in range(10):
    if num % 2 == 0:
        continue
    print(num)

Nested Loops Loops can be nested inside other loops to handle more complex tasks.

# Example of nested loops
for i in range(3):
    for j in range(2):
        print(f"i: {i}, j: {j}")
Conclusion Loops are powerful tools for automating repetitive tasks and iterating over sequences efficiently.

''',

// Lessson 5

  'Lesson 5: Functions': '''

Functions are essential for structuring code into reusable blocks. They allow you to encapsulate code into single units that can be called with various inputs to perform tasks.

Defining a Function

A function is defined using the def keyword followed by the function name and parentheses. Parameters can be included in the parentheses.

def greet(name):
    print(f"Hello, {name}!")

Calling a Function

To execute a function, use its name followed by parentheses. Pass any required arguments inside the parentheses.

greet("Alice")  # Output: Hello, Alice!

Returning Values

Functions can return values using the return keyword, allowing you to use the function’s output elsewhere in your code.

def add(a, b):
    return a + b

result = add(5, 3)  # result is 8

Default Parameters

Default values can be set for parameters. If arguments are not provided during the function call, the default values are used.

def power(base, exponent=2):
    return base ** exponent

print(power(3))    # Output: 9
print(power(3, 3)) # Output: 27

Keyword Arguments

You can specify arguments by name when calling a function, which enhances readability and flexibility.

def describe_person(name, age):
    print(f"{name} is {age} years old.")

describe_person(age=30, name="Bob")  # Output: Bob is 30 years old.

Conclusion

Functions are a key concept in programming that help to organize and reuse code, making it more modular and manageable.

'''
};

final Map<String, Map<String, dynamic>> lessonContent = {
  // Lesson 1 Questions
  'Lesson 1: Introduction to Python': {
    'mcqs': [
      {
        'question': '1) What is Python primarily used for?',
        'options': ['Web development', 'Data analysis', 'Both', 'None'],
        'answer': 'Both'
      },
      {
        'question': '2) Who created Python?',
        'options': [
          'Guido van Rossum',
          'Linus Torvalds',
          'Bjarne Stroustrup',
          'James Gosling'
        ],
        'answer': 'Guido van Rossum'
      },
      {
        'question': '3) Python is an example of which programming paradigm?',
        'options': [
          'Procedural',
          'Object-oriented',
          'Functional',
          'All of the above'
        ],
        'answer': 'All of the above'
      },
      {
        'question': '4) Which extension is used for Python files?',
        'options': ['.py', '.java', '.c', '.txt'],
        'answer': '.py'
      },
      {
        'question': '5) Is Python case-sensitive?',
        'options': ['Yes', 'No'],
        'answer': 'Yes'
      },
    ],
    'programming': [
      {
        'question':
            '6) Fill in the blanks to complete the Python program that prints "Hello, World!"',
        'code': '''
print(___("Hello, World!"))
''',
        'blanks': ['print'],
      },
      {
        'question':
            '7) Fill in the blanks to complete the Python program that calculates the sum of a list',
        'code': '''
numbers = [1, 2, 3, 4, 5]
total = ___(numbers)
print(total)
''',
        'blanks': ['sum'],
      },
      {
        'question':
            '8) Fill in the blanks to complete the Python function that checks if a number is prime',
        'code': '''
def is_prime(num):
    if num <= 1:
        return False
    for i in range(2, ___):
        if num % i == 0:
            return False
    return True
''',
        'blanks': ['num'],
      },
      {
        'question':
            '9) Fill in the blanks to complete the Python program that reverses a string',
        'code': '''
def reverse_string(s):
    return s[___]
string = "hello"
print(reverse_string(string))
''',
        'blanks': ['::-1'],
      },
      {
        'question':
            '10) Fill in the blanks to complete the Python program that finds the largest of three numbers',
        'code': '''
a = 10
b = 20
c = 30
largest = max(___, b, c)
print(largest)
''',
        'blanks': ['a'],
      },
    ],
  },

  // Lesson 2 Questions
  'Lesson 2: Variables and Data Types': {
    'mcqs': [
      {
        'question':
            '1) Which of the following is a valid variable name in Python?',
        'options': [
          '2nd_variable',
          'variable_name',
          'variable-name',
          'variable name'
        ],
        'answer': 'variable_name'
      },
      {
        'question': '2) What type of value is `3.14` in Python?',
        'options': ['String', 'Integer', 'Float', 'Boolean'],
        'answer': 'Float'
      },
      {
        'question':
            '3) Which operator is used to concatenate strings in Python?',
        'options': ['+', '-', '*', '/'],
        'answer': '+'
      },
      {
        'question': '4) What is the result of `type(10)` in Python?',
        'options': [
          '<class \'int\'>',
          '<class \'float\'>',
          '<class \'str\'>',
          '<class \'bool\'>'
        ],
        'answer': '<class \'int\'>'
      },
      {
        'question':
            '5) Which of the following is not a basic data type in Python?',
        'options': ['List', 'Dictionary', 'Tuple', 'Character'],
        'answer': 'Character'
      },
    ],
    'programming': [
      {
        'question':
            '6) Fill in the blanks to create a variable named `age` and assign it the value `25`',
        'code': '''
age = ___
print(age)
''',
        'blanks': ['25'],
      },
      {
        'question':
            '7) Fill in the blanks to convert the string `number_str` to an integer',
        'code': '''
number_str = "100"
number_int = ___(number_str)
print(number_int)
''',
        'blanks': ['int'],
      },
      {
        'question':
            '8) Fill in the blanks to complete the program that checks the type of a variable `value`',
        'code': '''
value = 42
print(___(value))
''',
        'blanks': ['type'],
      },
      {
        'question':
            '9) Fill in the blanks to concatenate the variables `first_name` and `last_name`',
        'code': '''
first_name = "John"
last_name = "Doe"
full_name = ___ + " " + ___
print(full_name)
''',
        'blanks': ['first_name', 'last_name'],
      },
      {
        'question':
            '10) Fill in the blanks to create a list with three elements and print the second element',
        'code': '''
my_list = [1, 2, 3]
print(my_list[___])
''',
        'blanks': ['1'],
      },
    ],
  },

  // Lesson 3 Questions
  'Lesson 3: Conditional Statements': {
    'mcqs': [
      {
        'question': '1) What does the `if` statement do in Python?',
        'options': [
          'Defines a function',
          'Loops through a range',
          'Executes a block of code if a condition is true',
          'Handles exceptions'
        ],
        'answer': 'Executes a block of code if a condition is true'
      },
      {
        'question':
            '2) Which statement is used to handle alternative conditions?',
        'options': ['if', 'elif', 'else', 'switch'],
        'answer': 'elif'
      },
      {
        'question':
            '3) What is the result of the following code snippet? `x = 10; if x > 5: print("Yes") else: print("No")`',
        'options': ['Yes', 'No', 'Error', 'None'],
        'answer': 'Yes'
      },
      {
        'question':
            '4) How do you check multiple conditions in an `if` statement?',
        'options': [
          'Using `if`',
          'Using `elif`',
          'Using logical operators',
          'Using `switch`'
        ],
        'answer': 'Using logical operators'
      },
      {
        'question': '5) What is the purpose of the `else` statement?',
        'options': [
          'To handle additional conditions',
          'To provide an alternative code block if the `if` condition is false',
          'To define a function',
          'To handle exceptions'
        ],
        'answer':
            'To provide an alternative code block if the `if` condition is false'
      }
    ],
    'programming': [
      {
        'question':
            '1) Fill in the blanks to complete a program that prints "Adult" if age is greater than or equal to 18',
        'code': '''
age = 22
if ___ >= 18:
    print("Adult")
''',
        'blanks': ['age']
      },
      {
        'question':
            '2) Fill in the blanks to complete a program that prints "Teenager" if age is between 13 and 19 inclusive',
        'code': '''
age = 16
if ___ >= 13 and ___ <= 19:
    print("Teenager")
''',
        'blanks': ['age', 'age']
      },
      {
        'question':
            '3) Fill in the blanks to create a program that prints "Not Eligible" if a person is under 18 and "Eligible" otherwise',
        'code': '''
age = 17
if ___ < 18:
    print("Not Eligible")
else:
    print("Eligible")
''',
        'blanks': ['age']
      },
      {
        'question':
            '4) Fill in the blanks to complete a program that prints "Pass" if score is greater than or equal to 50',
        'code': '''
score = 55
if ___ >= 50:
    print("Pass")
''',
        'blanks': ['score']
      },
      {
        'question':
            '5) Fill in the blanks to complete a program that prints "Correct" if the answer matches the given string',
        'code': '''
answer = "Python"
if ___ == "Python":
    print("Correct")
''',
        'blanks': ['answer']
      }
    ],
  },

  // Lesson 4 Questions
  'Lesson 4: Loops in Python': {
    'mcqs': [
      {
        'question': '1) What does the `for` loop do in Python?',
        'options': [
          'Iterates over a sequence',
          'Checks a condition',
          'Creates a new function',
          'Handles exceptions'
        ],
        'answer': 'Iterates over a sequence'
      },
      {
        'question':
            '2) What will the following code print? `for i in range(3): print(i)`',
        'options': ['0 1 2', '1 2 3', '0 1 2 3', '3 2 1'],
        'answer': '0 1 2'
      },
      {
        'question':
            '3) Which loop is used to repeat code while a condition is true?',
        'options': ['for', 'while', 'repeat', 'until'],
        'answer': 'while'
      },
      {
        'question':
            '4) What is the purpose of the `break` statement in a loop?',
        'options': [
          'Skip the rest of the current iteration',
          'Exit the loop prematurely',
          'Pause the loop execution',
          'Repeat the loop indefinitely'
        ],
        'answer': 'Exit the loop prematurely'
      },
      {
        'question':
            '5) What will the following code print? `count = 0; while count < 3: print(count); count += 1`',
        'options': ['0 1 2', '1 2 3', '0 1 2 3', '1 2'],
        'answer': '0 1 2'
      }
    ],
    'programming': [
      {
        'question':
            '1) Fill in the blanks to create a `for` loop that prints numbers from 1 to 5',
        'code': '''
for i in range(___):
    print(i + 1)
''',
        'blanks': ['5']
      },
      {
        'question':
            '2) Fill in the blanks to complete a `while` loop that prints numbers from 10 to 5',
        'code': '''
num = 10
while ___ >= 5:
    print(num)
    num -= 1
''',
        'blanks': ['num']
      },
      {
        'question':
            '3) Fill in the blanks to use `break` to exit the loop when `count` is equal to 3',
        'code': '''
for count in range(5):
    if ___ == 3:
        break
    print(count)
''',
        'blanks': ['count']
      },
      {
        'question':
            '4) Fill in the blanks to use `continue` to skip even numbers and print only odd numbers from 1 to 10',
        'code': '''
for num in range(1, 11):
    if ___ % 2 == 0:
        continue
    print(num)
''',
        'blanks': ['num']
      },
      {
        'question':
            '5) Fill in the blanks to create a nested loop that prints a 3x2 grid of asterisks',
        'code': '''
for i in range(___):
    for j in range(___):
        print("*", end=" ")
    print()
''',
        'blanks': ['3', '2']
      }
    ]
  },

  // Lesson 5 Questions
  'Lesson 5: Functions': {
    'mcqs': [
      {
        'question': '1) What keyword is used to define a function in Python?',
        'options': ['func', 'define', 'def', 'function'],
        'answer': 'def'
      },
      {
        'question': '2) What does the `return` statement do in a function?',
        'options': [
          'Prints the value to the console',
          'Exits the function and returns a value',
          'Defines a new function',
          'Loops through the function body'
        ],
        'answer': 'Exits the function and returns a value'
      },
      {
        'question': '3) How can you call a function with keyword arguments?',
        'options': [
          'function_name(arguments)',
          'function_name(arg1=value1, arg2=value2)',
          'function_name(arg1, arg2)',
          'function_name(value1, value2)'
        ],
        'answer': 'function_name(arg1=value1, arg2=value2)'
      },
      {
        'question':
            '4) What is the purpose of default parameters in Python functions?',
        'options': [
          'They must be provided during the function call',
          'They are used only if no arguments are passed',
          'They can only be used with non-default parameters',
          'They must be listed first in the parameter list'
        ],
        'answer': 'They are used only if no arguments are passed'
      },
      {
        'question':
            '5) What will the following code print? `def greet(name): return "Hello, " + name; print(greet("Alice"))`',
        'options': ['Hello, Alice', 'Hello, ', 'Alice', 'None'],
        'answer': 'Hello, Alice'
      }
    ],
    'programming': [
      {
        'question':
            '1) Fill in the blanks to complete a function that returns the maximum of two numbers.',
        'code': '''
def max_of_two(a, b):
    if ___ > ___:
        return ___
    else:
        return ___
''',
        'blanks': ['a', 'b', 'a', 'b']
      },
      {
        'question':
            '2) Fill in the blanks to create a function that calculates the factorial of a number.',
        'code': '''
def factorial(n):
    if n == 0:
        return 1
    else:
        return n * factorial(___)
''',
        'blanks': ['n - 1']
      },
      {
        'question':
            '3) Fill in the blanks to create a function that prints a message a specified number of times.',
        'code': '''
def repeat_message(message, times):
    for ___ in range(___):
        print(message)
''',
        'blanks': ['i', 'times']
      },
      {
        'question':
            '4) Fill in the blanks to complete a function that returns "Hello" followed by the name provided as an argument.',
        'code': '''
def greet(name):
    return "Hello, " + ___
''',
        'blanks': ['name']
      },
      {
        'question':
            '5) Fill in the blanks to create a function that calculates and returns the area of a rectangle.',
        'code': '''
def area_of_rectangle(width, height):
    return ___ * ___
''',
        'blanks': ['width', 'height']
      }
    ]
  },
};
