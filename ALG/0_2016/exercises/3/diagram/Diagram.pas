PROGRAM Diagram;

CONST POLTICIAN_COUNT = 2;
  PADDING_CENTER = 1;
  HEADER_MIN_LENGTH = 8;
  EXIT_FAILURE = 1;

TYPE PollResult = RECORD
  PositiveVotes: SHORTINT;
  NegativeVotes: SHORTINT;
END;

TYPE PoliticianPollResults = ARRAY[1..POLTICIAN_COUNT] OF PollResult;

VAR politicianPoll: PoliticianPollResults;
  extremeValues: PollResult;

(* Calculates the absolute value of the parameter. *)
FUNCTION Abs(n: INTEGER): INTEGER;
  VAR square: LONGINT;
BEGIN
  square := (n * n);
  Abs := Round(Sqrt(Square));
END;

(* Determines the maximum of the two input parameters. *)
FUNCTION Max2(number_a, number_b: INTEGER): INTEGER;
BEGIN
  IF number_a > number_b THEN BEGIN
    Max2 := number_a;
  END
  ELSE BEGIN
    Max2 := number_b;
  END;
END;

(*
  Rounds a number and returns the result without the trailing 0
  --> divides result by 10.
*)
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

(*
Reads the result of the poll.

In addition, the input is validated.
Furthermore, the maximum and the minimum values required for displaying purposes are stored.
*)
PROCEDURE DeterminePoliticianRating(VAR pollResult: PoliticianPollResults; VAR extremeValues: PollResult);
  CONST NEGATIVE_VOTES_MIN = -100;
    NEGATIVE_VOTES_MAX = 100;
    POSITIVE_VOTES_MAX = 100;
    POSITIVE_VOTES_MIN = 0;

  VAR i: SMALLINT;
BEGIN
  FOR i := 1 TO POLTICIAN_COUNT DO BEGIN
    Write('Please enter the number of negative poll results for politician ', i, '>');
    ReadLn(pollResult[i].NegativeVotes);
    IF (pollResult[i].NegativeVotes > NEGATIVE_VOTES_MAX) OR (pollResult[i].NegativeVotes < NEGATIVE_VOTES_MIN) THEN BEGIN
      (* invalid input --> terminate program *)
      WriteLn('Please enter a valid integer between ', NEGATIVE_VOTES_MIN, ' and ', NEGATIVE_VOTES_MAX);
      System.Halt(EXIT_FAILURE);
    END;
    pollResult[i].NegativeVotes := Abs(pollResult[i].NegativeVotes);

    Write('Please enter the number of positive poll results for politician ', i, '>');
    ReadLn(pollResult[i].PositiveVotes);
    IF
		  (pollResult[i].PositiveVotes > POSITIVE_VOTES_MAX)
		  OR
      (pollResult[i].PositiveVotes < POSITIVE_VOTES_MIN)
    THEN BEGIN
      (* invalid input --> terminate program *)
      WriteLn('Please enter a valid integer between ', POSITIVE_VOTES_MIN, ' and ', POSITIVE_VOTES_MAX);
      System.Halt(EXIT_FAILURE);
    END;
    pollResult[i].PositiveVotes := Abs(pollResult[i].PositiveVotes);

	  (* round the value and retrieve the relevant part (without trailing 0) *)
    pollResult[i].NegativeVotes := Round10(pollResult[i].NegativeVotes);
    pollResult[i].PositiveVotes := Round10(pollResult[i].PositiveVotes);

    IF (pollResult[i].NegativeVotes + pollResult[i].PositiveVotes) > 10 THEN BEGIN
      (* input exceeds 100 per cent --> terminate the program *)
      WriteLn('The two rounded values you entered exceed 100 per cent which means the values are invalid.');
      System.Halt(EXIT_FAILURE);
    END;

    (* Determine the extreme values of the total input. *)
    extremeValues.NegativeVotes := Max2(extremeValues.NegativeVotes, pollResult[i].NegativeVotes);
    extremeValues.PositiveVotes := Max2(extremeValues.PositiveVotes, pollResult[i].PositiveVotes);
  END;
END;

(* Prints the correct number of X representing the positive and negative votes. *)
PROCEDURE PrintRow
(
  negative_votes, positive_votes: SMALLINT;
  columnLengthNegative, columnLengthPositive: SMALLINT
);
  VAR i: SMALLINT;
BEGIN
  (* print the negative votes *)
  FOR i := columnLengthNegative DOWNTO 1 DO BEGIN
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

  (* print the positive votes *)
  FOR i := 1 TO columnLengthPositive DO BEGIN
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

(* Print the heading naming the left (negative) and right(positive) column. *)
PROCEDURE PrintHeader(columnLengthNegative, columnLengthPositive: SMALLINT);
  VAR i: SMALLINT;
BEGIN
  Write('  ');

  i := columnLengthNegative;
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
  WHILE i <= columnLengthPositive DO BEGIN
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

  FOR i := 1 TO columnLengthNegative DO BEGIN
    Write('-');
  END;

  Write('+');

  FOR i := 1 TO columnLengthPositive DO BEGIN
    Write('-');
  END;

  WriteLn('');
END;

(* Prints the heading and the result for each politician. *)
PROCEDURE PrintPoliticianRating(VAR extremeValues: PollResult; VAR pollResult: PoliticianPollResults);
  VAR i: SMALLINT;
    columnLengthNegative, columnLengthPositive: SMALLINT;
BEGIN
  columnLengthNegative := Max2((HEADER_MIN_LENGTH + PADDING_CENTER), (extremeValues.NegativeVotes + PADDING_CENTER));
  columnLengthPositive := Max2((HEADER_MIN_LENGTH + PADDING_CENTER), (extremeValues.PositiveVotes + PADDING_CENTER));

  PrintHeader(columnLengthNegative, columnLengthPositive);
  FOR i := 1 TO POLTICIAN_COUNT DO BEGIN
    Write(i, ' ');
    PrintRow(pollResult[i].NegativeVotes, pollResult[i].PositiveVotes, columnLengthNegative, columnLengthPositive);
  END;
END;

BEGIN
  DeterminePoliticianRating(politicianPoll, extremeValues);
  PrintPoliticianRating(extremeValues, politicianPoll);
END.