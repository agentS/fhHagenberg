PROGRAM DataTypes;

CONST MAX_SIZE = 16;
  MAX_STUDENTS = 22;

TYPE TrafficLightColour = ( red, yellow, green );
TYPE DemoString = STRING[10];
TYPE MyString = ARRAY[0..10] OF CHAR;
TYPE MySmallField = ARRAY[1..10] OF BYTE;
TYPE MyIntField = ARRAY[1..MAX_SIZE] OF SMALLINT;
TYPE StudentScore = ARRAY[1..MAX_STUDENTS] OF ARRAY[1..MAX_SIZE] OF BYTE;
(*
TYPE StudentScore = ARRAY[1..MAX_STUDENTS, 1..10] OF BYTE;
important: a single data type is used for all kind of arrays
*)

TYPE LetterCount = ARRAY[CHAR] OF INTEGER;
TYPE Figure = (king, queen, rock, bishop, knight, pawn, empty);

TYPE DateType = RECORD
  day: 1..31;
  month: 1..12;
  year: WORD;
END;
TYPE StudentType = RECORD
  first_name: STRING[30];
  last_name: STRING[50];
  matriculation_number: LONGINT;
  date_of_birth: DateType;
END;
Type StudentArray = ARRAY[1..MAX_STUDENTS] OF StudentType;

PROCEDURE WriteStudent(VAR student_to_print: StudentType);
BEGIN
  WriteLn('Name: ', student_to_print.first_name, ' ', student_to_print.last_name);
  WriteLn('M#: ', student_to_print.matriculation_number);
  WriteLn('Date of birth: ', student_to_print.date_of_birth.day, '.', student_to_print.date_of_birth.month, '.', student_to_print.date_of_birth.year);
END;

VAR ch: CHAR;
  colour: TrafficLightColour;
  text_a: STRING;
  text_b: DemoString;
  i: INTEGER;
  text_length: INTEGER;
  arr: MyIntField;
  scores: StudentScore;
  letters: LetterCount;
  board: ARRAY[ 'a'..'h', 1..8 ] OF Figure;
  c: CHAR;
  j: INTEGER;
  estudiante, estudiante_b: StudentType;
  estudiantes: StudentArray;

BEGIN

  ch := 'a';
  colour := yellow;
  
  WriteLn('Ord(', 'a', '): ', Ord('a'));
  WriteLn('Ord(ch): ', Ord(ch));
  WriteLn('Chr(100): ', Chr(100));
  WriteLn('Pred(ch): ', Pred(ch));
  WriteLn('Succ(ch): ', Succ(ch));
  
  WriteLn('Ord(colour): ', Ord(colour));
  WriteLn('Pred(colour): ', Pred(colour));
  WriteLn('Succ(colour): ', Succ(colour));
  WriteLn('Low(colour): ', Low(colour));
  WriteLn('High(colour): ', High(colour));
  WriteLn('Low(CHAR): ', Ord(Low(CHAR)));
  WriteLn('High(CHAR): ', ord(High(CHAR)));
  WriteLn('Low(BYTE): ', Ord(Low(BYTE)));
  WriteLn('High(BYTE): ', ord(High(BYTE)));
  WriteLn('SizeOf(INTEGER): ', SizeOf(INTEGER), ' Byte');
  
  (* this is a comment *)
  (*
   * Hey there people, I'm Bobby Brown.
   * They say I'm the cutest boy in town.
   * My car is fast
   * And my teeth are shiny.
  *)
  text_a := 'H3llo';
  WriteLn('Length(text_a): ', Length(text_a));
  text_a[1] := 'h';
  WriteLn('first character of text_a: ', text_a[1]);
  WriteLn('Length(text_a) alternative: ', Ord(text_a[0]));
  text_length := Length(text_a);
  FOR i := 1 TO text_length DO BEGIN
    WriteLn(i, ': ', text_a[i]);
  END;
  WriteLn('Sizeof(text_a): ', SizeOf(text_a), ' Byte');
  text_b := 'c0d3' + ' ' + 'hard';
  WriteLn(text_b);
  
  FOR i := 1 TO MAX_SIZE DO BEGIN
    arr[i] := 20;
    Write(arr[i], ' ');
  END;
  WriteLn('');
  
  scores[1, 5] := 24;
  WriteLn(scores[1][5]);
  
  letters['A'] := 54;
  WriteLn(letters['A']);
  
  FOR c := 'a' TO 'h' DO BEGIN
    FOR j := 1 TO 8 DO BEGIN
      board[c, j] := empty;
    END;
  END;
  
  estudiante.first_name := 'Johannes';
  estudiante.last_name := 'Huber';
  estudiante.matriculation_number := 1610307103;
  estudiante.date_of_birth.day := 4;
  estudiante.date_of_birth.month := 3;
  estudiante.date_of_birth.year := 1994;
  
  WITH estudiante_b DO BEGIN
    first_name := 'Ricarda';
    last_name := 'Mayr';
    matriculation_number := 1610307104;
    WITH date_of_birth DO BEGIN
      day := 18;
      month := 6;
      year := 1995;
    END;
  END;
  
  WriteStudent(estudiante);
  WriteStudent(estudiante_b);
  estudiantes[1] := estudiante;
  estudiantes[2] := estudiante_b;
  FOR i := 1 TO 2 DO BEGIN
    WriteStudent(estudiantes[i]);
  END;
END.