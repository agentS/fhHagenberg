FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = LottoFunction

all: $(PROGNAME)

$(PROGNAME): LottoFunction.pas
	$(FPC) $(CFLAGS) LottoFunction.pas

clean:
	rm -f $(PROGNAME) $(PROGNAME).o