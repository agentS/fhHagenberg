FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = Diagram

all: $(PROGNAME)

$(PROGNAME): $(PROGNAME).pas
	$(FPC) $(CFLAGS) $(PROGNAME).pas

clean:
	rm -f $(PROGNAME) $(PROGNAME).o
