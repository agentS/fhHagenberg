Program FloatingMean;

VAR
	floatingMeanCount: SMALLINT;
	floatingMeanSum: LONGINT;

FUNCTION MeanA(value: SMALLINT): REAL;
BEGIN
	floatingMeanSum := floatingMeanSum + value;
	Inc(floatingMeanCount);
	MeanA := floatingMeanSum / floatingMeanCount;
END;

FUNCTION MeanStateMachine(value: SMALLINT): REAL;
BEGIN
	(* a = f(e, s) *)
	MeanStateMachine := (floatingMeanSum + value) / (floatingMeanCount + 1);


	(* s = g(e, s) *)
	floatingMeanSum := floatingMeanSum + value;
	Inc(floatingMeanCount);
END;

PROCEDURE MeanParameters(value: SMALLINT; VAR actualSum: LONGINT; VAR actualCount: SMALLINT; VAR mean: REAL);
BEGIN
	Inc(actualCount);
	actualSum := actualSum + value;
	mean := actualSum / actualCount;
END;

PROCEDURE InitFloatingMean(VAR sum: LONGINT; VAR count: SMALLINT);
BEGIN
	sum := 0;
	count := 0;
END;

VAR
	actualSum: LONGINT;
	actualCount: SMALLINT;
	meany: REAL;
BEGIN
	floatingMeanCount := 0;
	floatingMeanSum := 0;
	WriteLn('2 -> ', MeanA(2):1:2);
	WriteLn('4 -> ', MeanA(4):1:2);
	WriteLn('9 -> ', MeanA(9):1:2);
	WriteLn('1 -> ', MeanA(1):1:2);

	WriteLn('state machine: ');
	floatingMeanCount := 0;
	floatingMeanSum := 0;
	WriteLn('2 -> ', MeanStateMachine(2):1:2);
	WriteLn('4 -> ', MeanStateMachine(4):1:2);
	WriteLn('9 -> ', MeanStateMachine(9):1:2);
	WriteLn('1 -> ', MeanStateMachine(1):1:2);

	WriteLn('parameters: ');
	meany := 0;
	InitFloatingMean(actualSum, actualCount);
	MeanParameters(2, actualSum, actualCount, meany);
	WriteLn('2 -> ', meany:1:2);
	MeanParameters(4, actualSum, actualCount, meany);
	WriteLn('4 -> ', meany:1:2);
	MeanParameters(9, actualSum, actualCount, meany);
	WriteLn('9 -> ', meany:1:2);
	MeanParameters(1, actualSum, actualCount, meany);
	WriteLn('1 -> ', meany:1:2);
END.