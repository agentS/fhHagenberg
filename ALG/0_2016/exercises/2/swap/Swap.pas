PROGRAM Swap;

PROCEDURE SwapReal(VAR a, b: REAL);
  VAR temporary_storage: REAL;
BEGIN
  temporary_storage := a;
  a := b;
  b := temporary_storage;
END;

PROCEDURE SwapInt(VAR a, b: INTEGER);
  VAR temporary_storage: INTEGER;
BEGIN
  temporary_storage := a;
  a := b;
  b := temporary_storage;
END;

BEGIN
END.
