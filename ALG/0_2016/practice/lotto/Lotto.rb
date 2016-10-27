def factorial(n)
	result = 1;
	2.upto(n) { |i|
		result *= i
	}
	return result
end

drawed_numbers = 6
total_numbers = 45

factorial_drawed_numbers = factorial(drawed_numbers)
factorial_total_numbers = factorial(total_numbers)
factorial_total_numbers_minus_drawed_numbers = factorial(total_numbers - drawed_numbers)

bc = (factorial_total_numbers / (factorial_drawed_numbers * factorial_total_numbers_minus_drawed_numbers))
puts("Lotto #{drawed_numbers} aus #{total_numbers}: #{bc}")