srcdir=.
prefix = /usr
libdir = $(prefix)/lib64
OBJS = fsync.o open.o checkfd.o
CFLAGS ?= -Ofast
LIBRARY = nosync.so

nosync.so: $(OBJS)
	$(CC) -shared -fPIC $(CFLAGS) -o $@ $+ -ldl -lpthread

%.o: %.c
	$(CC) -c -fPIC $(CFLAGS) -o $@ $+

install: $(LIBRARY)
	install -d $(libdir)/nosync
	install -p $< $(libdir)/nosync/

test_nosync: test_nosync.c
	$(CC) $(CFLAGS) -o $@ $+

test: test_nosync $(LIBRARY)
	LD_LIBRARY=$(srcdir)/$(LIBRARY) ./test_nosync

clean:
	@rm -f $(OBJS) nosync.so test_nosync
