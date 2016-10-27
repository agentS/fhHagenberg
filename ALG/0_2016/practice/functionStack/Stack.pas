PROGRAM StackDemo;

PROCEDURE F1;
BEGIN
  // do something useful
END;

PROCEDURE F0;
BEGIN
  F0();  // F0 must already have been declared
END;

BEGIN
  F0();
  F0();
  F1();
END.
