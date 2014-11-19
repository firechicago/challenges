# The output of the program should look as follows:

# What is the amount being invested: 1000
# What is the annual interest rate (percentage): 10
# How many years will it accrue interest: 25

# The final value will be $10834.71 after 25 years.

# ====================
# YOUR CODE GOES HERE
# ====================
print "What is the amount being invested:"
principal = gets.chomp.to_f
print "What is the annual interest rate (percentage):"
rate = (gets.chomp.to_f)/100
print "How many years will it accrue interest:"
years = gets.chomp.to_i
final = principal * ((1+rate) ** years)
puts ""
printf("The final value will be $%.2f after #{years} years.\n", final)
