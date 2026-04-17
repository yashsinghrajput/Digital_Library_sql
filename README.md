# Digital_Library_sqlzz
SafeLog – Password Validator

SafeLog is a simple Java program that checks whether a password meets basic security rules. It ensures that users cannot proceed until they enter a strong password and clearly tells them what is missing.

This project shows how input validation works in real systems while keeping the logic easy to understand.

What it does
Takes a password as input
Checks minimum length (8 characters)
Ensures at least one uppercase letter
Ensures at least one digit
Gives clear feedback for each failed rule
Repeats until a valid password is entered
Concepts Used
String manipulation
for loops for character checking
Character class methods (isUpperCase, isDigit)
while loop for repeated input
Modular methods for clean structure
How to run
javac PasswordValidator.java
java PasswordValidator

This project focused on validation logic and clean code structure. It can be extended by adding more rules like special characters or integrating it into a larger application.
