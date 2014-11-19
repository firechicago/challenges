### Instructions

Write a program which calculates the value of an investment given the initial amount *PV*, the annual interest rate *i*, and the number of years to invest *n*. Use the following formula to calculate the future value:

![Compound Interest Equation](https://upload.wikimedia.org/math/e/0/c/e0ca87a82c591a0e0610792963751fd5.png)

Add your code to `calculator.rb`.

### Sample Usage

```no-highlight
$ ruby calculator.rb
What is the amount being invested: 1000
What is the annual interest rate (percentage): 10
How many years will it accrue interest: 25

The final value will be $10834.71 after 25 years.
```

### Tips

* The following snippet can be used to prompt the user for a number and store their input in a variable:

```ruby
print "Enter some value: "
some_value = gets.chomp.to_f
```

* To raise some number *b* to a power *n* (i.e. *b<sup>n</sup>*) we can use the `**` operator in Ruby:

```ruby
10 ** 2 #=> 100
4 ** 3 #=> 64
```

* The `printf` method can be used to format numbers with a specific number of decimal places. The documentation for [`sprintf`][sprintf] contains information on how the format string works. The following snippet will print the value of Pi with two decimal places:

```ruby
pi = 3.14159
printf("The value of Pi is %.2f\n", pi)
# Outputs "The value of Pi is 3.14"
```

[sprintf]: http://ruby-doc.org/core-1.9.3/Kernel.html#method-i-sprintf
