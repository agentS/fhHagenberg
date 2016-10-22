PROGRAM ArithmeticMean;

VAR
  number: INTEGER;
  sum: LONGINT;
  count: INTEGER;
  result: REAL;
  input: STRING;

BEGIN
  sum := 0;
  count := 0;

  REPEAT BEGIN
    Write('Please enter an integer number greater or equal to 0: ');
    ReadLn(number);
    
    IF number > 0 THEN BEGIN
      sum := sum + number;
      count := count + 1;
    END;
  END
  UNTIL (number <= 0);
  
  IF count > 0 THEN BEGIN
    result := sum / count; // integer division: sum DIV count
    WriteLn('Mean: ', result:4:2); // result:4:2 is string formating 4 specifies the minimum number of digits and 2 specifies the number of digits after the decimal point
  END
  ELSE BEGIN
    WriteLn('Mean: 0');
  END;
END.