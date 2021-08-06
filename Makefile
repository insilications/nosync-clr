prefix = /usr
libdir = $(prefix)/lib64
OBJS = fsync.o open.o
CFLAGS ?= -Ofast

nosync.so: $(OBJS)
	$(CC) -shared -fPIC $(CFLAGS) -o $@ $+ -ldl -lpthread

%.o: %.c
	$(CC) -c -fPIC $(CFLAGS) -o $@ $+

install: nosync.so
	install -d $(libdir)/nosync
	install -p $< $(libdir)/nosync/

clean:
	@rm -f $(OBJS) nosync.so
