PROGRAM Lotto;

VAR
  drawed_numbers: INTEGER;
  total_numbers: INTEGER;
  factorial_drawed_numbers, factorial_total_numbers, factorial_total_and_drawed_numbers: REAL;
  bc: REAL;

PROCEDURE PrintHelp;
  CONST PROG_NAME = 'Lotto';
BEGIN
  WriteLn(PROG_NAME);
END;

// parameter list = formal parameters
// call by value --> input-only parameter: value is copied into the procedure's memory --> input parameter supplied by the caller can either be an expression or a variable
// call by reference --> IO parameter: memory address of the variable is copied the procedure's memory --> input parameter supplied by the caller must be a variable
PROCEDURE Factorial(n: INTEGER; VAR calc_result: REAL);
  VAR i: INTEGER;
BEGIN
  calc_result := 1;
  FOR i := 2 TO n DO BEGIN
    calc_result := calc_result * i;
  END;
END;

BEGIN
  // (m! / (n! * (m-n)!))
  // n! = 1 * 2 * 3 * 4 * ... * n
  // 0! = 1

  drawed_numbers := 6;
  total_numbers := 45;

  factorial_drawed_numbers := 0;
  factorial_total_numbers := 0;
  factorial_total_and_drawed_numbers := 0;

  Factorial(drawed_numbers, factorial_drawed_numbers);
  Factorial(total_numbers, factorial_total_numbers);
  Factorial((total_numbers - drawed_numbers), factorial_total_and_drawed_numbers);

  bc := (factorial_total_numbers / (factorial_drawed_numbers * factorial_total_and_drawed_numbers));

  WriteLn('Lotto ', drawed_numbers, ' aus ', total_numbers, ': ', bc:7:0);
END.