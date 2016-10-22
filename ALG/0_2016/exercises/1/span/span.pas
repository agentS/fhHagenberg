PROGRAM Range;

VAR read_number : INTEGER;
  min, max, result: INTEGER;
  count: INTEGER;
  

BEGIN
  min := 32767;
  max := 0;

  REPEAT BEGIN
    Write('Please enter an integer number: ');
    ReadLn(read_number);
    
    IF read_number > 0 THEN BEGIN
      IF read_number < min THEN BEGIN
        min := read_number;
      END;
      IF read_number > max THEN BEGIN
        max := read_number;
      END;
      count := count + 1;
    END;
  END UNTIL read_number <= 0;
  
  IF count > 0 THEN BEGIN
    result := (max - min);
    WriteLn('Range: ', result);
  END
  ELSE BEGIN
    WriteLn('Range: 0')
  END;
END.