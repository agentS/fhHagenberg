PROGRAM NumberConverter;

CONST MAX_BASE = 36;
  ASCII_0 = Ord('0');
  ASCII_9 = Ord('9');
  ASCII_A_UPPER = Ord('A');
  ASCII_Z_UPPER = Ord('Z');
  ASCII_A_LOWER = Ord('a');
  ASCII_Z_LOWER = Ord('z');
  ALPHANUMERIC_DIGIT_OFFSET = 10;

FUNCTION Power(base: SMALLINT; exponent: SMALLINT): SMALLINT;
  VAR i: INTEGER;
    result: SMALLINT;
BEGIN
  IF exponent > 0 THEN BEGIN
    result := base;
    FOR i := 2 TO exponent DO BEGIN
      result := result * base;
    END;
    Power := result;
  END
  ELSE BEGIN
    Power := 1;
  END;
END;

FUNCTION ToUpperCase(characterToConvert: CHAR): CHAR;
  VAR characterASCIIValue: BYTE;
BEGIN
  characterASCIIValue := Ord(characterToConvert);
  IF (characterASCIIValue >= ASCII_A_LOWER) AND (characterASCIIValue <= ASCII_A_UPPER) THEN BEGIN
    ToUpperCase := Chr(characterASCIIValue - (ASCII_A_LOWER - ASCII_A_UPPER));
  END
  ELSE BEGIN
    ToUpperCase := Chr(characterASCIIValue);
  END;
END;

FUNCTION ValueOf(digits: STRING; base: INTEGER): INTEGER;
  VAR i: INTEGER;
    numberOfDigits: INTEGER;
    processedDigit: BYTE;
    actualDigitASCIIValue: BYTE;
    decimalValue: INTEGER;
    invalidDigit: BOOLEAN;
BEGIN
  IF base <= MAX_BASE THEN BEGIN
    decimalValue := 0;
    numberOfDigits := Length(digits);
    i := Length(digits);
    invalidDigit := FALSE;
    WHILE (i >= 1) AND (invalidDigit = FALSE) DO BEGIN
      actualDigitASCIIValue := Ord(ToUpperCase(digits[i]));

      IF (actualDigitASCIIValue >= ASCII_0) AND (actualDigitASCIIValue <= ASCII_9) THEN BEGIN
        processedDigit := actualDigitASCIIValue - ASCII_0;
      END
      ELSE IF (actualDigitASCIIValue >= ASCII_A_UPPER) AND (actualDigitASCIIValue <= ASCII_Z_UPPER) THEN BEGIN
        processedDigit := actualDigitASCIIValue - ASCII_A_UPPER + ALPHANUMERIC_DIGIT_OFFSET;
      END
      ELSE BEGIN
        WriteLn('Invalid character "', digits[i], '"! Please limit your input to digits and letters.');
        invalidDigit := TRUE;
      END;

      IF invalidDigit = FALSE THEN BEGIN
        IF processedDigit < base THEN BEGIN
          IF processedDigit <> 0 THEN BEGIN
            decimalValue := decimalValue + (processedDigit * Power(base, numberOfDigits - i));
          END;
        END ELSE BEGIN
          WriteLn('The character "', digits[i], '" exceeds the specified base.');
          invalidDigit := TRUE;
        END;
      END;

      i := i - 1;
    END;

    IF invalidDigit = FALSE THEN BEGIN
      ValueOf := decimalValue;
    END
    ELSE BEGIN
      ValueOf := (-1);
    END;
  END
  ELSE BEGIN
    ValueOf := (-1);
  END;
END;

FUNCTION DigitsOf(value: INTEGER; base: INTEGER): INTEGER;
  VAR i: INTEGER;

BEGIN
  
END;

BEGIN
  //WriteLn(ValueOf(';<>=', 100));
  //WriteLn(ValueOf('20010', 2));
  //WriteLn(ValueOf('10020', 2));

  WriteLn(ValueOf('Z9', 36));
  WriteLn(ValueOf('10010', 2));
END.