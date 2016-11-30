FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = PointerDemo

all: $(PROGNAME)

$(PROGNAME): $(PROGNAME).pas
	$(FPC) $(CFLAGS) $(PROGNAME).pas

clean:
	rm -f $(PROGNAME) $(PROGNAME).o
