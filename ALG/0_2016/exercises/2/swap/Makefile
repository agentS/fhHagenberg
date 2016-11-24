FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = Swap

all: $(PROGNAME)

$(PROGNAME): Swap.pas
	$(FPC) $(CFLAGS) Swap.pas

clean:
	rm -f $(PROGNAME) Swap.o
