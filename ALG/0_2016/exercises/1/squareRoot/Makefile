FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = SquareRoot

all: $(PROGNAME)

$(PROGNAME): SquareRoot.pas
	$(FPC) $(CFLAGS) SquareRoot.pas

clean:
	rm -f $(PROGNAME) SquareRoot.o