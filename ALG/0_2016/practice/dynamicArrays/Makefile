FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = DynamicArrays

all: $(PROGNAME)

$(PROGNAME): $(PROGNAME).pas
	$(FPC) $(CFLAGS) $(PROGNAME).pas

clean:
	rm -f $(PROGNAME) $(PROGNAME).o
