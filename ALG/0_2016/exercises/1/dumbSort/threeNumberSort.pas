PROGRAM ThreeNumberSort;

VAR a, b, c: INTEGER;
  swap_help: INTEGER;

BEGIN
  Write('Please enter the first number: ');
  ReadLn(a);
  Write('Please enter the second number: ');
  ReadLn(b);
  Write('Please enter the third number: ');
  ReadLn(c);
  
  IF a > b THEN BEGIN
    swap_help := a;
    a := b;
    b := swap_help;
  END;
  IF a > c THEN BEGIN
    swap_help := a;
    a := c;
    c := swap_help;
  END;
  IF b > c THEN BEGIN
    swap_help := b;
    b := c;
    c := swap_help;
  END;
  
  WriteLn('Sorted numbers ascending: ', a, ' ', b, ' ', c, ' ');
END.