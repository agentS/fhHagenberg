PROGRAM NumberConverter;

CONST MAX_BASE = 36;
  MIN_BASE = 2;
  ASCII_0 = Ord('0');
  ASCII_9 = Ord('9');
  ASCII_A_UPPER = Ord('A');
  ASCII_Z_UPPER = Ord('Z');
  ASCII_A_LOWER = Ord('a');
  ASCII_Z_LOWER = Ord('z');
  ALPHANUMERIC_DIGIT_OFFSET = 10;
  MAX_STRING_REPRESENTATION_LENGTH = 5;

(* Determine base power exponent. *)
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

(* Convert a lower case ASCII character to upper case. *)
FUNCTION ToUpperCase(characterToConvert: CHAR): CHAR;
  VAR characterASCIIValue: BYTE;
BEGIN
  characterASCIIValue := Ord(characterToConvert);
  (* check if the character is a lower case character *)
  IF (characterASCIIValue >= ASCII_A_LOWER) AND (characterASCIIValue <= ASCII_A_UPPER) THEN BEGIN
    ToUpperCase := Chr(characterASCIIValue - (ASCII_A_LOWER - ASCII_A_UPPER));
  END
  ELSE BEGIN
    ToUpperCase := Chr(characterASCIIValue);
  END;
END;

(* Convert a number in an arbitary base into a decimal number. *)
FUNCTION ValueOf(digits: STRING; base: INTEGER): INTEGER;
  VAR i: INTEGER;
    numberOfDigits: INTEGER;
    processedDigit: BYTE;
    actualDigitASCIIValue: BYTE;
    decimalValue: INTEGER;
    invalidDigit: BOOLEAN;
BEGIN
  (* check if the base is within the allowed range *)
  IF (base >= MIN_BASE) AND (base <= MAX_BASE) THEN BEGIN
    decimalValue := 0;
    numberOfDigits := Length(digits);
    i := Length(digits);
    invalidDigit := FALSE;
    (* process the input string character by character in reverse order (as we can) *)
    WHILE (i >= 1) AND (invalidDigit = FALSE) DO BEGIN
      actualDigitASCIIValue := Ord(ToUpperCase(digits[i]));

      (* check if the character is a number or a letter *)
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
        (* check if the decimal value of the character is within the allowed range determined by the base *)
        IF processedDigit < base THEN BEGIN
          IF processedDigit <> 0 THEN BEGIN
            (* add the character multiplied by the base power the significance *)
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

(* Get the character representation of either a digit or a letter. *)
Function NumberToChar(number: INTEGER): CHAR;
BEGIN
  IF number >= ALPHANUMERIC_DIGIT_OFFSET THEN BEGIN
    NumberToChar := Chr(number - ALPHANUMERIC_DIGIT_OFFSET + ASCII_A_UPPER);
  END
  ELSE BEGIN
    NumberToChar := Chr(number + ASCII_0);
  END;
END;

FUNCTION DigitsOf(value: INTEGER; base: INTEGER): STRING;
  VAR i, j: SMALLINT;
  VAR remainder: INTEGER;
  VAR stringRepresentationReverse: STRING[MAX_STRING_REPRESENTATION_LENGTH];
  VAR stringRepresentation: STRING[MAX_STRING_REPRESENTATION_LENGTH];
BEGIN
  (* check if the base is within the allowed range *)
  IF (base >= MIN_BASE) AND (base <= MAX_BASE) THEN BEGIN
    i := 1;
	  (* use the Horner method for storing the digits in reverse order *)
    WHILE (value > 0) DO BEGIN
      remainder := value MOD base;
      stringRepresentationReverse[i] := NumberToChar(remainder);
      value := value DIV base;
      IF value > 0 THEN BEGIN
        i := i + 1;
      END;
    END;

	  (* reverse the order of the characters *)
    FOR j := i DOWNTO 1 DO BEGIN
      stringRepresentation[i - j + 1] := stringRepresentationReverse[j];
    END;
	  (* set the length of the result string *)
    stringRepresentation[0] := Chr(i);
    DigitsOf := stringRepresentation;
  END
  ELSE BEGIN
    DigitsOf := '';
  END;
END;

FUNCTION Sum(d0: STRING; b0: INTEGER; d1: STRING; b1: INTEGER): INTEGER;
  VAR numberA, numberB: INTEGER;
BEGIN
  numberA := ValueOf(d0, b0);
  numberB := ValueOf(d1, b1);
  IF (numberA <> (-1)) AND (numberB <> (-1)) THEN BEGIN
    Sum := numberA + numberB;
  END
  ELSE BEGIN
    Sum := (-1);
  END;
END;

FUNCTION Diff(d0: STRING; b0: INTEGER; d1: STRING; b1: INTEGER): INTEGER;
  VAR numberA, numberB: INTEGER;
BEGIN
  numberA := ValueOf(d0, b0);
  numberB := ValueOf(d1, b1);
  IF (numberA <> (-1)) AND (numberB <> (-1)) THEN BEGIN
    Diff := numberA - numberB;
  END
  ELSE BEGIN
    Diff := (-1);
  END;
END;

FUNCTION Prod(d0: STRING; b0: INTEGER; d1: STRING; b1: INTEGER): INTEGER;
  VAR numberA, numberB: INTEGER;
BEGIN
  numberA := ValueOf(d0, b0);
  numberB := ValueOf(d1, b1);
  IF (numberA <> (-1)) AND (numberB <> (-1)) THEN BEGIN
    Prod := numberA * numberB;
  END
  ELSE BEGIN
    Prod := (-1);
  END;
END;

FUNCTION Quot(d0: STRING; b0: INTEGER; d1: STRING; b1: INTEGER): INTEGER;
  VAR numberA, numberB: INTEGER;
BEGIN
  numberA := ValueOf(d0, b0);
  numberB := ValueOf(d1, b1);
  IF (numberA <> (-1)) AND (numberB > 0) THEN BEGIN
    Quot := numberA DIV numberB;
  END
  ELSE BEGIN
    Quot := (-1);
  END;
END;

BEGIN
  //WriteLn('ValueOf(XY, 37): ', ValueOf('XY', 37));
  //WriteLn('ValueOf(11001, -2): ', ValueOf('11001', -2));

  (*
  WriteLn('ValueOf(X;<>=, 36): ', ValueOf('X;<>=', 36));
  WriteLn('ValueOf(20010, 2): ', ValueOf('20010', 2));
  WriteLn('ValueOf(10020, 2): ', ValueOf('10020', 2));
  *)

  (*)
  WriteLn('ValueOf(Z9, 36): ', ValueOf('Z9', 36));
  WriteLn('ValueOf(10010, 2): ', ValueOf('10010', 2));
  WriteLn('ValueOf(1180, 10): ', ValueOf('1180', 10));
  *)
  (*
  WriteLn('DigitsOf(1269, 36): ', DigitsOf(1269, 36));
  WriteLn('DigitsOf(18, 2): ', DigitsOf(18, 2));
  WriteLn('DigitsOf(1180, 10): ', DigitsOf(1180, 10));
  *)
  
  (*
  WriteLn('Sum(Z9, 36, 10020, 2): ', Sum('Z9', 36, '10020', 2));
  WriteLn('Diff(Z9, 37, 10010, 2): ', Diff('Z9', 37, '10010', 2));
  WriteLn('Quot(Z9, 36, 0, 2): ', Quot('Z9', 36, '0', 2));
  WriteLn('Prod(L2, 26, 10020, 2): ', Prod('L2', 26, '10020', 2));
  *)

  WriteLn('Sum(Z9, 36, 10010, 2): ', Sum('Z9', 36, '10010', 2));
  WriteLn('Diff(Z9, 36, 10010, 2): ', Diff('Z9', 36, '10010', 2));
  WriteLn('Quot(Z9, 36, 10010, 2): ', Quot('Z9', 36, '10010', 2));
  WriteLn('Prod(L2, 26, 10010, 2): ', Prod('L2', 26, '10010', 2));
  
END.