PROGRAM ListDemo;

TYPE
	Node = ^NodeRec;
	List = Node;
	NodeRec = RECORD
		value: SMALLINT;
		next: Node;
	END;

PROCEDURE InitList(VAR l: List);
BEGIN
	l := NIL;
END;

FUNCTION CreateNode(value: SMALLINT): Node;
	VAR newNode: Node;
BEGIN
	New(newNode);

	(* IF newNode = NIL THEN BEGIN exception_handling END; *)
	newNode^.value := value;
	newNode^.next := NIL;

	CreateNode := newNode;
END;

PROCEDURE AppendNode(VAR collection: List; newNode: Node);
	VAR lastNode: Node;
BEGIN
	IF collection = NIL THEN BEGIN
		collection := newNode;
	END
	ELSE BEGIN
		lastNode := collection;
		WHILE lastNode^.next <> NIL DO BEGIN
			lastNode := lastNode^.next;
		END;
		lastNode^.next := newNode;
	END;
END;

PROCEDURE PrependNode(VAR collection: List; newNode: Node);
BEGIN
	newNode^.next := collection;
	collection := newNode;
END;

PROCEDURE PrintList(collection: List);
	VAR printedNode: Node;
BEGIN
	printedNode := collection;
	WHILE printedNode <> NIL DO BEGIN
		Write(printedNode^.value, ', ');
		printedNode := printedNode^.next;
	END;
	WriteLn;
END;

PROCEDURE DisposeList(VAR collection: List);
	VAR deletedNode: Node;
BEGIN
	WHILE collection <> NIL DO BEGIN
		deletedNode := collection;
		collection := deletedNode^.next;
		Dispose(deletedNode);
	END;
	(* KEEP IN MIND: collection has to become NIL in this method *)
END;

VAR
	collection: List;
BEGIN
	InitList(collection);
	PrintList(collection);
	WriteLn('list head = ', LONGINT(collection));
	PrependNode(collection, CreateNode(18));
	WriteLn('list head = ', LONGINT(collection));
	AppendNode(collection, CreateNode(6));
	WriteLn('list head = ', LONGINT(collection));
	AppendNode(collection, CreateNode(1995));
	AppendNode(collection, CreateNode(103));
	AppendNode(collection, CreateNode(3462));
	PrintList(collection);
	PrependNode(collection, CreateNode(1180));
	WriteLn('list head = ', LONGINT(collection));
	PrintList(collection);

	DisposeList(collection);
	WriteLn('list head = ', LONGINT(collection));
	PrintList(collection);
END.