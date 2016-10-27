FPC = fpc

CFLAGS = -Mtp -Criot -gl

PROGNAME = ConvertToBinary

all: $(PROGNAME)

$(PROGNAME): ConvertToBinary.pas
	$(FPC) $(CFLAGS) ConvertToBinary.pas

clean:
	rm -f $(PROGNAME) $(PROGNAME).o
