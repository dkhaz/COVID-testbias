module parameters
    implicit none
    double precision,dimension(:),allocatable::x_data,y_data,y_errors
    double precision, parameter::pi=3.141592653589793d0
    integer,parameter::total_param_numbers=2
    Logical::fit_binned=.True.    
end module parameters
module utils
    implicit none
    contains
        

    function fitting_function_tan(x,params_array)
        implicit none
        double precision,dimension(:),intent(in)::x,params_array
        double precision::param_1,param_2        
        double precision,dimension(size(x))::fitting_function_tan
        param_1=params_array(1)
        param_2=params_array(2)
        fitting_function_tan=(param_1/param_2)*tan(param_2*x)
    end function fitting_function_tan

        
    function chi_square(data,errors,theory)
        implicit none
        double precision,dimension(:),intent(in)::data,errors,theory
        double precision::chi_square
        
        chi_square=sum((data-theory)*(data-theory)/(errors*errors))
        
    end function chi_square
    
end module utils



subroutine calfun(chi2val,tot_param_num,params,grad,need_grad,f_data)
    use utils
    use parameters
    implicit none
    double precision,intent(out)::chi2val
    integer::tot_param_num
    integer,intent(in)::need_grad
    double precision,dimension(tot_param_num),intent(in)::params,grad
    double precision::f_data,this_param_1,this_param_2,this_param_3
    double precision,dimension(:),allocatable::Y_theory,variance
    
    
    if(need_grad/=0) stop 'Gradient is not available' 
    
    allocate(Y_theory(size(x_data)))

    
    Y_theory(:)=fitting_function_tan(x_data,params)
    
    chi2val=chi_square(y_data,y_errors,Y_theory)
end subroutine calfun
