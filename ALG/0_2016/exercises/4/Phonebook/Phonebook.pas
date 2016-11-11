PROGRAM Phonebook;

CONST MAX = 10;

TYPE FirstNameString = STRING[20];
TYPE LastNameString = STRING[30];

TYPE Entry = RECORD
	firstName: FirstNameString;
	lastName: LastNameString;
	phoneNumber: INTEGER;
END;

TYPE EntryArray = ARRAY[1..MAX] OF Entry;

FUNCTION NrOfEntries(VAR entries: EntryArray): INTEGER;
	VAR count: INTEGER;
BEGIN
	count := 1;
	WHILE (count <= MAX) AND ((entries[count].firstName <> '') OR (entries[count].lastName <> '') OR (entries[count].phoneNumber <> 0)) DO BEGIN
		count := count + 1;
	END;
	NrOfEntries := count;
END;

FUNCTION GetIndexOfName(VAR entries: EntryArray; startIndex: INTEGER; fName: FirstNameString; lName: LastNameString): INTEGER;
	VAR i: INTEGER;
	VAR indexPhonebook: INTEGER;
BEGIN
	i := startIndex;
	indexPhonebook := MAX + 1;
	WHILE i <= MAX DO BEGIN
		IF (entries[i].firstName = fName) AND (entries[i].lastName = lName) THEN BEGIN
			indexPhonebook := i;
			i := MAX;
		END
		ELSE BEGIN
			i := i + 1;
		END;
	END;
	GetIndexOfName := indexPhonebook;
END;

PROCEDURE SearchNumber(VAR entries: EntryArray; fName: FirstNameString; lName : LastNameString);
	VAR matchCount: INTEGER;
	VAR i: INTEGER;
BEGIN
	matchCount := 0;
	i := 1;
	REPEAT BEGIN
		i := GetIndexOfName(entries, i, fName, lName);
		IF i <= MAX THEN BEGIN
			matchCount := matchCount + 1;
			WriteLn(entries[i].phoneNumber, ': ', entries[i].firstName, ' ', entries[i].lastName);
		END;
		i := i + 1;
	END UNTIL i >= MAX;
	IF matchCount = 0 THEN BEGIN
		WriteLn('No phone numbers found.');
	END;
END;

PROCEDURE SearchName(VAR entries: EntryArray; numberToSearch: INTEGER);
	VAR i: WORD;
BEGIN
	i := 1;
	WHILE i <= MAX DO BEGIN
		IF entries[i].phoneNumber = numberToSearch THEN BEGIN
			WriteLn(numberToSearch, ': ', entries[i].firstName, ' ', entries[i].lastName);
		END;
		i := i + 1;
	END;
END;

PROCEDURE AddEntry(VAR entries: EntryArray; fName: FirstNameString; lName: LastNameString; number: INTEGER);
	VAR newEntry: Entry;
		entryCount: INTEGER;
BEGIN
	entryCount := NrOfEntries(entries);
	IF entryCount <= MAX THEN BEGIN
		WITH newEntry DO BEGIN
			firstName := fName;
			lastName := lName;
			phoneNumber := number;
		END;
		entries[entryCount] := newEntry;
	END
	ELSE BEGIN
		WriteLn('You have too many entries in your phonebook. Please delete at least on entry.');
	END;
END;

PROCEDURE DeleteEntry(VAR entries: EntryArray; fName: FirstNameString; lName: LastNameString);
	VAR count: INTEGER;
		entryIndex: INTEGER;
		moveCounter: INTEGER;
BEGIN
	count := NrOfEntries(entries);
	entryIndex := GetIndexOfName(entries, 1, fName, lName);
	IF entryIndex <= count THEN BEGIN
		FOR moveCounter := entryIndex + 1 TO count DO BEGIN
			entries[moveCounter - 1] := entries[moveCounter];
		END;
	END
	ELSE BEGIN
		WriteLn('Entry ', fName, ' ', lName, ' not found.');
	END;
END;

VAR entries: EntryArray;
BEGIN
	AddEntry(entries, 'Jimi', 'Hendrix', 42);
	AddEntry(entries, 'Michael', 'Stipe', 586);
	AddEntry(entries, 'Double Michael', 'Stipe', 586);
	AddEntry(entries, 'Maca', 'Rena', 6);
	AddEntry(entries, 'Jimi', 'Hendrix', 1180);
	SearchNumber(entries, 'Michael', 'Stipe');
	SearchNumber(entries, 'Jimi', 'Hendrix');
	SearchName(entries, 586);
	DeleteEntry(entries, 'Double Michael', 'Stipe');
	SearchNumber(entries, 'Double Michael', 'Stipe');
	DeleteEntry(entries, 'Double Michael', 'Stipe');
END.