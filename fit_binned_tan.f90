program fit_testing
    use utils
    use parameters
    implicit none
    include 'nlopt.f'

    double precision, allocatable, dimension(:)::this_theory,best_theory,best_params
    double precision, allocatable, dimension(:)::STVAL,params_low,params_up,this_grad,this_x
    double precision::best_chisquare,chisquare,Asymp_PH
    integer::this_need_grad,samples,num_entry
    Integer::i,j,k,Total_days,readunit,writeunit,dummy_num,num_data,logunit   
    integer,parameter::Avg_hosp_day=12
    character(len=128)::command_line,datafile
    Integer (Kind=8) :: OPT,ires
    Interface
        subroutine calfun(chi2val,tot_param_num,params,grad,need_grad,f_data)
            implicit none
            double precision,intent(out)::chi2val
            integer::tot_param_num
            integer,intent(in)::need_grad
            double precision,dimension(tot_param_num),intent(in)::params,grad
            double precision::f_data
       end subroutine calfun
    end interface
    
    datafile="input_data/binned_data.txt"
    command_line="wc -l < "//trim(adjustl(datafile))//" > linenum.txt" 
    print*,command_line 
    Call execute_command_line(command_line)
    OPEN(newunit=writeunit,file='linenum.txt') 
    READ(writeunit,*) Num_Entry 
    close(writeunit)
    print*,'File Length',Num_Entry   

    num_data=Num_Entry-1 ! Ignoring one header file
    allocate(x_data(num_data),y_data(num_data),y_errors(num_data))
    
    OPEN(NEWUNIT=readunit,FILE=datafile,action='read',status='old')  
    ! Just read header
    read(readunit,*) 
    do i=1,num_data
            read(readunit,*)x_data(i),y_data(i),y_errors(i)
    end do
    close(readunit)
    opt = 0
    allocate(params_low(total_param_numbers),params_up(total_param_numbers),STVAL(total_param_numbers))
    allocate(this_grad(total_param_numbers))
    this_grad=0d0
    
    !=== Ranges for first parameter ===============
    params_low(1)=6d0
    params_up(1)=12d0
    !=== Ranges for second parameter ===============
    params_low(2)=0.001d0
    params_up(2)=0.04d0
    
    !========= Starting values of parameters ==========
    
    STVAL(1)=9d0
    STVAL(2)=0.02d0
    this_need_grad=0
    
    call nlo_create(opt, NLOPT_LN_SBPLX,total_param_numbers)
!     print*,'creation done'
    call nlo_set_lower_bounds(ires, opt, params_low)
 
    if(ires<0) stop 'NLOPT failed at lower bounds'
    
    call nlo_set_upper_bounds(ires, opt, params_up)
!     print*,'bounds set'
    
    if(ires<0) stop 'NLOPT failed at upper bounds'
    
    call nlo_set_min_objective(ires, opt, calfun, 0)
!     print*,'objective set'
    if(ires<0) stop 'NLOPT failed at objective'

    call nlo_set_xtol_rel(ires, opt, 1.D-5)
!     print*,'tolerence set'
    if(ires<0) stop 'NLOPT failed at tolerence'
     call nlo_optimize(ires, opt, STVAL, best_chisquare)
     if(ires<0) stop 'NLOPT failed at optimize'

    call nlo_destroy(opt)     

   OPEN(NEWUNIT=logunit,FILE='plot_data/Log-Tan.txt',action='write',status='replace')     

    print*,'Optimization Done: chisquare=',best_chisquare
    print*,'Best fit parameters: f_0=',real(STVAL(1)),'b=',real(STVAL(2))
    Asymp_PH=pi/2d0/STVAL(2)
    print*,'Asymptotic limit of p+/H_N:',real(Asymp_PH)
    write(logunit,*)'Optimization Done: chisquare=',best_chisquare
    write(logunit,*) 'Best fit parameters: f_0=',STVAL(1),'b=',STVAL(2)
    
 
    samples=2000    
    allocate(this_x(samples),best_theory(samples))    
    forall(i=1:samples) this_x(i)=dble(i-1)*Asymp_PH/dble(samples-1)
    
    best_theory=fitting_function_tan(this_x,STVAL)
    
    OPEN(NEWUNIT=writeunit,FILE='plot_data/Bestfit-Tan.txt',action='write',status='replace')  
    do i=1,samples
        write(writeunit,*)this_x(i),best_theory(i)
    end do
    close(writeunit)
        
end program fit_testing

