PROGRAM Maximum;

FUNCTION Max2(number_a, number_b: INTEGER): INTEGER;
BEGIN
  IF number_a > number_b THEN BEGIN
    Max2 := number_a;
  END
  ELSE BEGIN
    Max2 := number_b;
  END;
END;

FUNCTION Max3a(a, b, c: INTEGER): INTEGER;
  VAR max: INTEGER;
BEGIN
  IF a > b THEN BEGIN
    max := a;
  END
  ELSE BEGIN
    max := b;
  END;

  IF c > max THEN BEGIN
    max := c;
  END;

  Max3a := max;
END;

FUNCTION Max3b(a, b, c: INTEGER): INTEGER;
BEGIN
  Max3b := Max2(Max2(a, b), c);
END;

BEGIN
  //WriteLn(Max2(5, 10));
  //WriteLn(Max2(500, 50));
  //WriteLn('');

  WriteLn(Max3a(5, 10, 15));
  WriteLn(Max3a(5, 10, 7));
  WriteLn(Max3a(15, 10, 8));
  WriteLn(Max3a(15, 10, 12));
  WriteLn('');

  WriteLn(Max3b(5, 10, 15));
  WriteLn(Max3b(5, 10, 7));
  WriteLn(Max3b(15, 10, 8));
  WriteLn(Max3b(15, 10, 12));
END.
