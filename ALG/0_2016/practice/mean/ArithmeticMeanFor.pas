PROGRAM ArithmeticMean;

VAR
  i: INTEGER;
  number: INTEGER;
  sum, count: INTEGER;
  result: REAL;
  number_quantity: INTEGER;

BEGIN
  sum := 0;
  count := 0;

  Write
  ('How many numbers do you want to enter? >');
  ReadLn(number_quantity);
  
  IF number_quantity > 0 THEN BEGIN
    FOR i := 1 TO number_quantity DO BEGIN
      Write('Please enter an integer number greater or equal to 0: ');
      ReadLn(number);
      
      sum := sum + number;
      count := count + 1;
    END;
  
    result := sum / count;
    WriteLn('Mean: ', result:4:2); // result:4:2 is string formating 4 specifies the minimum number of digits and 2 specifies the number of digits after the decimal point
  END;
END.