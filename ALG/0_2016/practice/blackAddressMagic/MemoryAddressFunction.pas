PROGRAM MemoryAddressFunction;

CONST LOW_INDEX = 1;
	UPPER_INDEX = 10;

TYPE IntegerArray = ARRAY [LOW_INDEX..UPPER_INDEX] OF INTEGER;

FUNCTION MAF0(startAddr: LONGINT; index, typeSize: INTEGER): LONGINT;
BEGIN
	MAF0 := startAddr + ((index - LOW_INDEX) * typeSize);
END;

VAR a: IntegerArray;
BEGIN
	WriteLn('@a: ', LONGINT(@a));
	WriteLn('MAF0(a, 3): ', MAF0(LONGINT(@a), 3, SizeOf(INTEGER)));
	WriteLn('@a[3]: ', LONGINT(@a[3]));
END.