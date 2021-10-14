#
# makefile for ccalc
#
OBJS += ccalc.o cmath.o lex.o parse.o

# rules
%.c: %.y
	bison -o $(@:%.o=%.d) $<

%.c: %.l
	flex -o$(@:%.o=%.d) -i $<

# dependencies
ccalc: parse.c lex.c parse.h $(OBJS)
	@echo gcc -occalc $(OBJS)
	@gcc  -occalc $(OBJS)
	@echo ' '

# source
ccalc.o: ccalc.c parse.h ccalc.h

cmath.o: cmath.c parse.h ccalc.h

lex.o: lex.c parse.h ccalc.h

parse.o: parse.c parse.h ccalc.h

parse.c: parse.y

lex.c: lex.l



