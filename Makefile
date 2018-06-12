XS_NAME=pg_digest
XS_VERSION=1.0

EXTENSION=$(XS_NAME)
DATA=$(XS_NAME)--$(XS_VERSION).sql
MODULE_big=$(XS_NAME)

SRCS=$(XS_NAME).c
OBJS=$(SRCS:.c=.o)

PGXS:=$(shell pg_config --pgxs)
include $(PGXS)
