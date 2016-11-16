PROGRAM RationalNumberArithmetic;

TYPE
	Rational = RECORD
		numerator, denominator: INTEGER;
	END;
	IntegerInputString = STRING[5];

PROCEDURE PrintRational(VAR rationalToPrint: Rational);
BEGIN
	WriteLn(rationalToPrint.numerator, '/', rationalToPrint.denominator);
END;

FUNCTION GreatestCommonDivisor(p, q: INTEGER): INTEGER;
	VAR remainder: INTEGER;
BEGIN
	REPEAT
		remainder := p MOD q;
		IF remainder <> 0 THEN BEGIN
			p := q;
			q := remainder;
		END;
	UNTIL remainder = 0;
	GreatestCommonDivisor := q;
END;

FUNCTION LeastCommonMultiple(m, n: INTEGER): INTEGER;
BEGIN
END;

PROCEDURE ReduceRational(VAR rationalToReduce: Rational);
	VAR gcd: INTEGER;
BEGIN
	gcd := GreatestCommonDivisor(rationalToReduce.numerator, rationalToReduce.denominator);
	rationalToReduce.numerator := rationalToReduce.numerator DIV gcd;
	rationalToReduce.denominator := rationalToReduce.denominator DIV gcd;
END;

PROCEDURE ReadRational(VAR result: Rational);
	VAR inputString: IntegerInputString;
		errorIndex: INTEGER;
BEGIN
	Write('Please enter the numerator> ');
	ReadLn(inputString);
	Val(inputString, result.numerator, errorIndex);
	IF errorIndex <> 0 THEN BEGIN
		WriteLn('You entered an invalid numerator. Please enter a valid integer number. You are allowed to enter negative numbers.');
		System.Halt(1);
	END;

	Write('Please enter the denominator> ');
	ReadLn(inputString);
	Val(inputString, result.denominator, errorIndex);
	IF (errorIndex <> 0) OR (result.denominator <= 0) THEN BEGIN
		WriteLn('You entered an invalid denominator. Please enter an integer greater than 0. If you want to enter a negative number please enter a negative numerator.');
		System.Halt(1);
	END;
	ReduceRational(result);
END;

PROCEDURE MultiplyRational(VAR a, b: Rational; VAR c: Rational);
BEGIN
	c.numerator := a.numerator * b.numerator;
	c.denominator := a.denominator * b.denominator;
	ReduceRational(c);
END;

PROCEDURE DivideRational(VAR a, b: Rational; VAR c: Rational);
BEGIN
	c.numerator := a.numerator * b.denominator;
	c.denominator := a.denominator * b.numerator;
	ReduceRational(c);
END;

VAR r0, r1, r2: Rational;
BEGIN
	(*WriteLn(GreatestCommonDivisor(5, 13));
	WriteLn(GreatestCommonDivisor(216, 378));*)

	//ReadRational(r2);

	r0.numerator := 2;
	r0.denominator := 8;
	r1.numerator := 26;
	r1.denominator := 13;
	(*ReduceRational(r0);
	PrintRational(r0);
	ReduceRational(r1);
	PrintRational(r1);
	ReduceRational(r2);*)

	MultiplyRational(r0, r1, r2);
	PrintRational(r2);
	DivideRational(r1, r0, r2);
	PrintRational(r2);
	DivideRational(r0, r1, r2);
	PrintRational(r2);
END.