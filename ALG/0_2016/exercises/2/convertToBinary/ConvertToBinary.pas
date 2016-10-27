PROGRAM Converter;

CONST MIN_VALUE = 0;
  MAX_VALUE = 255;
  BINARY_DIGITS = 8;
  EXIT_FAILURE = 1;

VAR int_number: INTEGER;
VAR binary_number: ARRAY[1..BINARY_DIGITS] OF BOOLEAN;

FUNCTION Power(base, exponent: INTEGER): INTEGER;
  VAR i: INTEGER;
  VAR calc_result: INTEGER;
BEGIN
  calc_result := 1;
  FOR i := 1 TO exponent DO BEGIN
    calc_result := calc_result * base;
  END;
  Power := calc_result;
END;

PROCEDURE Convert2Binary(d: INTEGER; VAR binary_representation: ARRAY OF BOOLEAN);
  VAR i: INTEGER;
  VAR power_result: INTEGER;
BEGIN
  IF (d >= MIN_VALUE) AND (d <= MAX_VALUE) THEN BEGIN
    FOR i := BINARY_DIGITS DOWNTO 1 DO BEGIN
      power_result := Power(2, (i - 1));
      
      IF d >= power_result THEN BEGIN
        d := d - power_result;
        binary_representation[i - 1] := TRUE;
      END
      ELSE BEGIN
        binary_representation[i - 1] := FALSE;
      END;
    END;
  END;
END;

PROCEDURE PrintBinaryNumberArray(binary_number: ARRAY OF BOOLEAN);
  VAR i: INTEGER;
BEGIN
  Write('Binary representation: ');
  FOR i := BINARY_DIGITS DOWNTO 1 DO BEGIN
    IF binary_number[i - 1] = TRUE THEN BEGIN
      Write('T');
    END
    ELSE BEGIN
      Write('F');
    END;
    Write(' ');
  END;
  WriteLn('');
END;

BEGIN
  Write('Please enter an integer number between ', MIN_VALUE, ' and ', MAX_VALUE, '>');
  ReadLn(int_number);
  IF (int_number >= MIN_VALUE) AND (int_number <= MAX_VALUE) THEN BEGIN
    Convert2Binary(int_number, binary_number);
    PrintBinaryNumberArray(binary_number);
  END
  ELSE BEGIN
    WriteLn('Please enter a valid integer between ', MIN_VALUE, ' and ', MAX_VALUE);
  END;
END.
