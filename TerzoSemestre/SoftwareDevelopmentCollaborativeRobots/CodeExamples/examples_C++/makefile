CXXFLAGS = -Wall -std=c++14 -fsanitize=address
LDFLAGS= -fsanitize=address
CPP=g++
LD=g++

.SUFFIXES:
.SUFFIXES: .o .cpp

EXECS = destructor copy1 referencearg pointerarg overload complex

SRCS_destructor = destructor.cpp 
OBJS_destructor = ${SRCS_destructor:.cpp=.o}

SRCS_copy1 = copy1.cpp myclass.cpp  
OBJS_copy1 = ${SRCS_copy1:.cpp=.o}

SRCS_referencearg = referencearg.cpp 
OBJS_referencearg = ${SRCS_referencearg:.cpp=.o}

SRCS_pointerarg = pointerarg.cpp 
OBJS_pointerarg = ${SRCS_pointerarg:.cpp=.o}

SRCS_overload = overload.cpp 
OBJS_overload = ${SRCS_overload:.cpp=.o}

SRCS_complex = complex.cpp comp_main.cpp  
OBJS_complex = ${SRCS_complex:.cpp=.o}


all: $(EXECS)

.cpp.o:
	$(CPP) $(CXXFLAGS) -c $<

destructor: $(OBJS_destructor)
	$(LD) $(LDFLAGS) -o $@ $^

copy1: $(OBJS_copy1)
	$(LD) $(LDFLAGS) -o $@ $^

referencearg: $(OBJS_referencearg)
	$(LD) $(LDFLAGS) -o $@ $^

pointerarg: $(OBJS_pointerarg)
	$(LD) $(LDFLAGS) -o $@ $^

overload: $(OBJS_overload)
	$(LD) $(LDFLAGS) -o $@ $^

complex: $(OBJS_complex)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	rm -rf *.o
	rm -rf $(EXECS)

cleanedit:
	rm -rf *~

