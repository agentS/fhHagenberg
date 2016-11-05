PROGRAM PoliticianPoll;

CONST POLTICIAN_COUNT = 6;
  INDEX_NEGATIVE_VOTES = 1;
  INDEX_POSITIVE_VOTES = 2;
  PADDING_CENTER = 1;
  HEADER_MIN_LENGTH = 8;
  EXIT_FAILURE = 1;

TYPE POLITICIAN_POLL_RESULT = ARRAY[1..POLTICIAN_COUNT, 1..2] OF INTEGER;

VAR politician_poll: POLITICIAN_POLL_RESULT;
  max_negative_poll_value, max_positive_poll_value: INTEGER;

FUNCTION Abs(n: INTEGER): INTEGER;
  VAR square: LONGINT;
BEGIN
  square := (n * n);
  Abs := Round(Sqrt(Square));
END;

FUNCTION Max2(number_a, number_b: INTEGER): INTEGER;
BEGIN
  IF number_a > number_b THEN BEGIN
    Max2 := number_a;
  END
  ELSE BEGIN
    Max2 := number_b;
  END;
END;

FUNCTION Round10(number_to_round: INTEGER): INTEGER;
  CONST ROUNDING_ACCURACY = 10;

  VAR digit_post_10, digit_pre_10: INTEGER;
BEGIN
  digit_post_10 := number_to_round MOD ROUNDING_ACCURACY;
  digit_pre_10 := number_to_round DIV 10;
  IF digit_post_10 < 5 THEN BEGIN
    Round10 := digit_pre_10;
  END
  ELSE BEGIN
    Round10 := (digit_pre_10 + 1);
  END;
END;

PROCEDURE DeterminePoliticianRating(VAR poll_result: POLITICIAN_POLL_RESULT; VAR max_negative_value, max_positive_value: INTEGER);
  CONST NEGATIVE_VOTES_MIN = -100;
    NEGATIVE_VOTES_MAX = 100;
    POSITIVE_VOTES_MAX = 100;
    POSITIVE_VOTES_MIN = 0;

  VAR i: INTEGER;
BEGIN
  FOR i := 1 TO POLTICIAN_COUNT DO BEGIN
    Write('Please enter the number of negative poll results for politician ', i, '>');
    ReadLn(poll_result[i][INDEX_NEGATIVE_VOTES]);
    IF (poll_result[i][INDEX_NEGATIVE_VOTES] > NEGATIVE_VOTES_MAX) OR (poll_result[i][INDEX_NEGATIVE_VOTES] < NEGATIVE_VOTES_MIN) THEN BEGIN
      // invalid input --> terminate program
      WriteLn('Please enter a valid integer between ', NEGATIVE_VOTES_MIN, ' and ', NEGATIVE_VOTES_MAX);
      System.Halt(EXIT_FAILURE);
    END;
    poll_result[i][INDEX_NEGATIVE_VOTES] := Abs(poll_result[i][INDEX_NEGATIVE_VOTES]);

    Write('Please enter the number of positive poll results for politician ', i, '>');
    ReadLn(poll_result[i][INDEX_POSITIVE_VOTES]);
    IF (poll_result[i][INDEX_POSITIVE_VOTES] > POSITIVE_VOTES_MAX) OR (poll_result[i][INDEX_POSITIVE_VOTES] < POSITIVE_VOTES_MIN) THEN BEGIN
      // invalid input --> terminate program
      WriteLn('Please enter a valid integer between ', POSITIVE_VOTES_MIN, ' and ', POSITIVE_VOTES_MAX);
      System.Halt(EXIT_FAILURE);
    END;
    poll_result[i][INDEX_POSITIVE_VOTES] := Abs(poll_result[i][INDEX_POSITIVE_VOTES]);

    poll_result[i][INDEX_NEGATIVE_VOTES] := Round10(poll_result[i][INDEX_NEGATIVE_VOTES]);
    poll_result[i][INDEX_POSITIVE_VOTES] := Round10(poll_result[i][INDEX_POSITIVE_VOTES]);

    IF (poll_result[i][INDEX_NEGATIVE_VOTES] + poll_result[i][INDEX_POSITIVE_VOTES]) > 10 THEN BEGIN
      // input exceeds 100 per cent --> terminate the program
      WriteLn('The two rounded values you entered exceed 100 per cent which means the values are invalid.');
      System.Halt(EXIT_FAILURE);
    END;

    max_negative_value := Max2(max_negative_value, poll_result[i][INDEX_NEGATIVE_VOTES]);
    max_positive_value := Max2(max_positive_value, poll_result[i][INDEX_POSITIVE_VOTES]);
  END;
END;

PROCEDURE PrintRow(negative_votes, positive_votes: INTEGER; column_length_negative, column_length_positive: INTEGER);
  VAR i: INTEGER;
BEGIN
  FOR i := column_length_negative DOWNTO 1 DO BEGIN
    IF i = 1 THEN BEGIN
      Write(' ');
    END
    ELSE BEGIN
      IF (i - 1) <= negative_votes THEN BEGIN
        Write('X');
      END
      ELSE BEGIN
        Write(' ');
      END;
    END;
  END;

  Write('|');

  FOR i := 1 TO column_length_positive DO BEGIN
    IF i > PADDING_CENTER THEN BEGIN
      IF (i - 1) > positive_votes THEN BEGIN
        Write(' ');
      END
      ELSE BEGIN
        Write('X');
      END;
    END
    ELSE BEGIN
      Write(' ');
    END;
  END;

  WriteLn('');
END;

PROCEDURE PrintHeader(column_length_negative, column_length_positive: INTEGER);
  VAR i: INTEGER;
BEGIN
  Write('  ');

  i := column_length_negative;
  WHILE i > 0 DO BEGIN
    IF i = 1 THEN BEGIN
      Write(' ');
    END
    ELSE BEGIN
      IF (i - 1) <= HEADER_MIN_LENGTH THEN BEGIN
        Write('negative');
        i := i - (HEADER_MIN_LENGTH - 1);
      END
      ELSE BEGIN
        Write(' ');
      END;
    END;
    i := i - 1;
  END;

  Write(' ');

  i := 1;
  WHILE i <= column_length_positive DO BEGIN
    IF i > PADDING_CENTER THEN BEGIN
      IF (i - 1) > HEADER_MIN_LENGTH THEN BEGIN
        Write(' ');
      END
      ELSE BEGIN
        Write('positive');
        i := i + (HEADER_MIN_LENGTH - 1);
      END;
    END
    ELSE BEGIN
      Write(' ');
    END;
    i := i + 1;
  END;
  WriteLn('');

  Write('  ');

  FOR i := 1 TO column_length_negative DO BEGIN
    Write('-');
  END;

  Write('+');

  FOR i := 1 TO column_length_positive DO BEGIN
    Write('-');
  END;

  WriteLn('');
END;

PROCEDURE PrintPoliticianRating(negative_max_value, positive_max_value: INTEGER; VAR poll_result: POLITICIAN_POLL_RESULT);
  CONST COLUMN_MIN_LENGTH = 8;
  
  VAR i: INTEGER;
    column_length_negative, column_length_positive: INTEGER;
BEGIN
  column_length_negative := Max2((COLUMN_MIN_LENGTH + PADDING_CENTER), (negative_max_value + PADDING_CENTER));
  column_length_positive := Max2((COLUMN_MIN_LENGTH + PADDING_CENTER), (positive_max_value + PADDING_CENTER));

  PrintHeader(column_length_negative, column_length_positive);
  FOR i := 1 TO POLTICIAN_COUNT DO BEGIN
    Write(i, ' ');
    PrintRow(poll_result[i][INDEX_NEGATIVE_VOTES], poll_result[i][INDEX_POSITIVE_VOTES], column_length_negative, column_length_positive);
  END;
END;

BEGIN
  DeterminePoliticianRating(politician_poll, max_negative_poll_value, max_positive_poll_value);
  PrintPoliticianRating(max_negative_poll_value, max_positive_poll_value, politician_poll);
END.