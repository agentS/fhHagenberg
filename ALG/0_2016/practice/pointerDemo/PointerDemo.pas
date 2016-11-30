PROGRAM PointerDemo;

TYPE IntPtr = ^SMALLINT;

PROCEDURE Swap(VAR a, b: SMALLINT);
	VAR temp: SMALLINT;
BEGIN
	temp := a;
	a := b;
	b := temp;
END;

PROCEDURE SwapPtr(a, b: IntPtr);
	VAR temp: SMALLINT;
BEGIN
	temp := a^;
	a^ := b^;
	b^ := temp;
END;

VAR
	i: SMALLINT;
	p: ^SMALLINT;
	a0, a1: SMALLINT;
BEGIN
	i := 18;
	WriteLn('i = ', i);

	p := @i;
	WriteLn('pointer initialised');
	WriteLn('p = ', p^);

	i := 55;
	WriteLn('');
	WriteLn('variable changed');
	WriteLn('i = ', i);
	WriteLn('p = ', p^);

	p^ := 27;
	WriteLn('');
	WriteLn('referenced value of the pointer modified');
	WriteLn('i = ', i);
	WriteLn('p = ', p^);

	WriteLn('');
	WriteLn('Call by reference uses pointers internally too: the references to the value are passed to the procedure and hidden from the programmer.');
	a0 := 3;
	a1 := 7;
	Swap(a0, a1);
	WriteLn('a0 = ', a0);
	WriteLn('a1 = ', a1);

	WriteLn('');
	WriteLn('The swap procedure implemented with pointers.');
	SwapPtr(@a0, @a1);
	WriteLn('a0 = ', a0);
	WriteLn('a1 = ', a1);

	p := NIL;
	WriteLn('');
	WriteLn('the address of p after setting it to NIL = ', LONGINT(p));
	New(p);
	WriteLn('');
	WriteLn('value (NOT ADDRESS) of p after creation = ', p^);
	WriteLn('address of p after creating an integer = ', LONGINT(p));
	Dispose(p);
	WriteLn('');
	WriteLn('address of the pointer after disposing it = ', LONGINT(p));
	WriteLn('');
	New(p);
	WriteLn('address of the pointer after reallocating it = ', LONGINT(p));
END.