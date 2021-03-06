PROGRAM TheMissingElement;

CONST MAX_ELEMENTS = 100;

TYPE IntArray = ARRAY[1..MAX_ELEMENTS] OF INTEGER;

VAR testElements: IntArray;

(* Searches the missing element in a row of unsorted numbers *)
FUNCTION MissingElement(VAR a: IntArray; n: INTEGER): INTEGER;
  VAR sum: INTEGER;
    arraySum: INTEGER;
    i: SMALLINT;
BEGIN
  IF n > 0 THEN BEGIN
    (* use a sum formula for determining the sum of the row *)
    sum := ((n + 1) * (n + 2)) DIV 2;
    
    (* calculate the sum of the row excluding the missing element *)
    FOR i := 1 TO n DO BEGIN
      arraySum := arraySum + a[i];
    END;
    (* determine the missing element *)
    MissingElement := (sum - arraySum);
    END
  ELSE BEGIN
    MissingElement := (-1);
  END;
END;

BEGIN
  (*
  WriteLn(MissingElement(testElements, 0));
  *)

  testElements[1] := 3;
  testElements[2] := 2;
  testElements[3] := 4;
  testElements[4] := 5;
  WriteLn(MissingElement(testElements, 4));

  testElements[1] := 3;
  testElements[2] := 2;
  testElements[3] := 4;
  testElements[4] := 1;
  WriteLn(MissingElement(testElements, 4));

  testElements[1] := 3;
  testElements[2] := 2;
  testElements[3] := 1;
  testElements[4] := 5;
  WriteLn(MissingElement(testElements, 4));

  testElements[1] := 5;
  testElements[2] := 2;
  testElements[3] := 4;
  testElements[4] := 1;
  testElements[5] := 6;
  WriteLn(MissingElement(testElements, 5));
END.