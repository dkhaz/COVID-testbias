F90C     = ifort
FFLAGS   = -qopenmp -O2 -ip -W0 -WB -fpp -standard-semantics -no-wrap-margin

Driver = fit_binned_tan
OBJFILES = utils.o $(Driver).o

LIBS   = -L. -lnlopt
INCS   = -I. -I/usr/local/include 

export FFLAGS
export DEBUGFLAGS
export F90C


%.o: %.f90
	$(F90C) $(FFLAGS) -c $*.f90

all :	covid_test

covid_test:	$(OBJFILES)
	$(F90C) $(FFLAGS) $(OBJFILES) -o covid_test $(LIBS) $(INCS)


run :
	time ./covid_test

clean:
	rm -f *.o *.mod *.d *.pc *.obj fort.* *.out plot_data/* covid_test 

