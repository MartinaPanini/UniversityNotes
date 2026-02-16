CXXFLAGS = -Wall -std=c++14  -MMD
LDFLAGS = 
CPP=g++
LD=g++

.SUFFIXES:
.SUFFIXES: .o .cpp

EXECS = copy1 manyobj complex breaktie shape shape_diag dominance dominance2 duplicate multiple vbase virt_in_constr 

SRCS_copy1 = copy1.cpp myclass.cpp 
OBJS_copy1 = ${SRCS_copy1:.cpp=.o}

SRCS_manyobj = manyobj.cpp manyobj_main.cpp 
OBJS_manyobj = ${SRCS_manyobj:.cpp=.o}

SRCS_complex = complex.cpp comp_main.cpp 
OBJS_complex = ${SRCS_complex:.cpp=.o}

SRCS_breaktie = breaktie.cpp 
OBJS_breaktie = ${SRCS_breaktie:.cpp=.o}

SRCS_shape = shape.cpp main.cpp circle.cpp rect.cpp triangle.cpp 
OBJS_shape = ${SRCS_shape:.cpp=.o}

SRCS_shape_diag = shapes_main.cpp shape.cpp circle.cpp rect.cpp triangle.cpp 
OBJS_shape_diag = ${SRCS_shape_diag:.cpp=.o}

SRCS_dominance = dominance.cpp 
OBJS_dominance = ${SRCS_dominance:.cpp=.o}

SRCS_dominance2 = dominance2.cpp 
OBJS_dominance2 = ${SRCS_dominance2:.cpp=.o}

SRCS_duplicate = duplicate.cpp 
OBJS_duplicate = ${SRCS_duplicate:.cpp=.o}

SRCS_multiple = multiple.cpp 
OBJS_multiple = ${SRCS_multiple:.cpp=.o}

SRCS_vbase = vbase.cpp 
OBJS_vbase = ${SRCS_vbase:.cpp=.o}

SRCS_virt_in_constr = virt_in_constr.cpp 
OBJS_virt_in_constr = ${SRCS_virt_in_constr:.cpp=.o}

ALL_SRCS = ${SRCS_copy1} ${SRCS_manyobj} ${SRCS_complex} ${SRCS_breaktie} ${SRCS_shape} ${SRCS_shape_diag} ${SRCS_dominance} ${SRCS_dominance2} ${SRCS_duplicate} ${SRCS_multiple} ${SRCS_vbase} ${SRCS_virt_in_constr} 
ALL_DEPS =  ${ALL_SRCS:.cpp=.d}

all : $(EXECS)

-include $(ALL_DEPS)

copy1.o : copy1.cpp
	$(CPP) $(CXXFLAGS)  -c $<

myclass.o : myclass.cpp
	$(CPP) $(CXXFLAGS)  -c $<

copy1 : $(OBJS_copy1)
	$(LD) -o $@ $^ $(LDFLAGS) 

manyobj.o : manyobj.cpp
	$(CPP) $(CXXFLAGS)  -c $<

manyobj_main.o : manyobj_main.cpp
	$(CPP) $(CXXFLAGS)  -c $<

manyobj : $(OBJS_manyobj)
	$(LD) -o $@ $^ $(LDFLAGS) 

complex.o : complex.cpp
	$(CPP) $(CXXFLAGS)  -c $<

comp_main.o : comp_main.cpp
	$(CPP) $(CXXFLAGS)  -c $<

complex : $(OBJS_complex)
	$(LD) -o $@ $^ $(LDFLAGS) 

breaktie.o : breaktie.cpp
	$(CPP) $(CXXFLAGS)  -c $<

breaktie : $(OBJS_breaktie)
	$(LD) -o $@ $^ $(LDFLAGS) 

shape.o : shape.cpp
	$(CPP) $(CXXFLAGS)  -c $<

main.o : main.cpp
	$(CPP) $(CXXFLAGS)  -c $<

circle.o : circle.cpp
	$(CPP) $(CXXFLAGS)  -c $<

rect.o : rect.cpp
	$(CPP) $(CXXFLAGS)  -c $<

triangle.o : triangle.cpp
	$(CPP) $(CXXFLAGS)  -c $<

shape : $(OBJS_shape)
	$(LD) -o $@ $^ $(LDFLAGS) 

shapes_main.o : shapes_main.cpp
	$(CPP) $(CXXFLAGS)  -c $<

shape_diag : $(OBJS_shape_diag)
	$(LD) -o $@ $^ $(LDFLAGS) 

dominance.o : dominance.cpp
	$(CPP) $(CXXFLAGS)  -c $<

dominance : $(OBJS_dominance)
	$(LD) -o $@ $^ $(LDFLAGS) 

dominance2.o : dominance2.cpp
	$(CPP) $(CXXFLAGS)  -c $<

dominance2 : $(OBJS_dominance2)
	$(LD) -o $@ $^ $(LDFLAGS) 

duplicate.o : duplicate.cpp
	$(CPP) $(CXXFLAGS)  -c $<

duplicate : $(OBJS_duplicate)
	$(LD) -o $@ $^ $(LDFLAGS) 

multiple.o : multiple.cpp
	$(CPP) $(CXXFLAGS)  -c $<

multiple : $(OBJS_multiple)
	$(LD) -o $@ $^ $(LDFLAGS) 

vbase.o : vbase.cpp
	$(CPP) $(CXXFLAGS)  -c $<

vbase : $(OBJS_vbase)
	$(LD) -o $@ $^ $(LDFLAGS) 

virt_in_constr.o : virt_in_constr.cpp
	$(CPP) $(CXXFLAGS)  -c $<

virt_in_constr : $(OBJS_virt_in_constr)
	$(LD) -o $@ $^ $(LDFLAGS) 

clean:
	rm -rf *.o
	rm -rf $(EXECS)

cleanedit:
	rm -rf *~
