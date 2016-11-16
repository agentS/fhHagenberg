PROGRAM Expressions;

(*
 * Expression = Term { ("+" | "-") Term }
 * Term = Fact { "*" | "/" Fact }
 * Fact = Operand {Operation Operand}
 * Fact = ident | number | "(" Expression ")"
 * ident = Constant | Variable
 *
 * example:
 * 3     +  5 * 4;
 * Term "+" Term
 *          Fact "*" Fact
 *          number   number
 *          5     *  4
 * 3      + 20
 * 23
 *)


BEGIN
END.