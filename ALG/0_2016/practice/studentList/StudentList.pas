PROGRAM StudentList;

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

FUNCTION CreateStudent(firstName, lastName: STRING; matrNumber: LONGINT;
    VAR sList: ARRAY OF StudentType;
    VAR sc: WORD): BOOLEAN;
BEGIN
  IF sc <= High(sList) THEN BEGIN
    WITH sList[sc] DO BEGIN
      first_name := firstName;
      last_name := lastName;
      matriculation_number := matrNumber;
    END;
    sc := sc + 1;
    CreateStudent := TRUE;
  END
  ELSE BEGIN
    CreateStudent := FALSE;
  END;
END;

PROCEDURE WriteStudent(VAR student_to_print: StudentType);
BEGIN
  WriteLn('Name: ', student_to_print.first_name, ' ', student_to_print.last_name);
  WriteLn('M#: ', student_to_print.matriculation_number);
  WriteLn('Date of birth: ', student_to_print.date_of_birth.day, '.', student_to_print.date_of_birth.month, '.', student_to_print.date_of_birth.year);
END;

PROCEDURE WriteStudents(VAR students: ARRAY OF StudentType; length : INTEGER);
  VAR i: INTEGER;
BEGIN
  WriteLn('BEGIN STUDENT LIST');
  WriteLn('---');
  FOR i := Low(students) TO (length - 1) DO BEGIN
    WriteStudent(students[i]);
    WriteLn('---');
  END;
  WriteLn('END STUDENT LIST');
  WriteLn('');
END;

VAR estudiante, estudiante_b: StudentType;
  estudiantes: ARRAY [0..2] OF StudentType;
  listCount: INTEGER;

BEGIN
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

  estudiantes[0] := estudiante;
  estudiantes[1] := estudiante_b;
  listCount := 2;  
  WriteStudents(estudiantes, listCount);
  WriteLn(CreateStudent('Thomas', 'Müller', 85, estudiantes, listCount));
  WriteStudents(estudiantes, listCount);
  WriteLn(CreateStudent('Heribert', 'Müller', 84, estudiantes, listCount));
  WriteStudents(estudiantes, listCount);
END.