PROGRAM SquareRoot;

CONST MAX_ITERATIONS = 50;

VAR x: INTEGER;
	loop_count: INTEGER;
	y_previous_iteration, y_actual_iteration, y_iteration_difference: REAL;
	e: REAL;

BEGIN
	Write('Please enter the number which square root you want to determine: ');
	ReadLn(x);
	IF x >= 0 THEN BEGIN
		Write('Please enter the error bound: ');
		ReadLn(e);
		IF e > 0 THEN BEGIN
			y_previous_iteration := 1;
			y_actual_iteration := 1;
			y_iteration_difference := 32767;
			loop_count := 0;

			WHILE (y_iteration_difference > e) AND (loop_count < MAX_ITERATIONS) DO BEGIN
				y_actual_iteration := (0.5 * (y_previous_iteration + (x / y_previous_iteration)));
				y_iteration_difference := y_actual_iteration - y_previous_iteration;
				
				// determine the absoulte value of the iteration difference
				IF y_iteration_difference < 0 THEN BEGIN
					y_iteration_difference := (-y_iteration_difference);
				END;

				y_previous_iteration := y_actual_iteration;

				loop_count := loop_count + 1;
			END;

			IF loop_count < MAX_ITERATIONS THEN BEGIN
				WriteLn('The square root is: ', y_actual_iteration:3:2);
			END
			ELSE BEGIN
				WriteLn('No exact enough approximation could be found within ', MAX_ITERATIONS, ' iterations.');
			END;
		END
		ELSE BEGIN
			WriteLn('Please enter an error bound greater than 0.');
		END;
	END
	ELSE BEGIN
		WriteLn('Please enter an integer which is greater or equal to 0.');
	END;
END.