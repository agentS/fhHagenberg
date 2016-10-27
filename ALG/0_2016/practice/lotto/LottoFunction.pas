PROGRAM Lotto;

PROCEDURE PrintHelp;
  CONST PROG_NAME = 'Lotto';
BEGIN
  WriteLn(PROG_NAME);
END;

FUNCTION Factorial(n: INTEGER): REAL;
  VAR i: INTEGER;
  VAR calc_result: REAL;
BEGIN
  calc_result := 1;
  FOR i := 2 TO n DO BEGIN
    calc_result := calc_result * i;
  END;

  Factorial := calc_result;
END;

FUNCTION BinomialCoefficient(drawed_numbers, total_numbers: INTEGER): REAL;
BEGIN
  // (m! / (n! * (m-n)!))
  // n! = 1 * 2 * 3 * 4 * ... * n
  // 0! = 1
  BinomialCoefficient := (Factorial(total_numbers) / (Factorial(drawed_numbers) * Factorial((total_numbers - drawed_numbers))));
END;

BEGIN
  WriteLn('Lotto 6 aus 45(A): ', BinomialCoefficient(6, 45):7:0);
  WriteLn('Lotto 6 aus 49(D): ', BinomialCoefficient(6, 49):7:0);
  WriteLn('Lotto 6 aus 90(I): ', BinomialCoefficient(6, 90):7:0);
END.
