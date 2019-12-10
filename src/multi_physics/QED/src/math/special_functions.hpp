#ifndef __PICSAR_MULTIPHYSICS_SPECIAL_FUNCTIONS__
#define __PICSAR_MULTIPHYSICS_SPECIAL_FUNCTIONS__

//This .hpp file is an extremely thin wrapper around special functions
//(Bessel functions for now) defined either in the STL (if C++17 is available)
//or in Boost library as a fallback.

//TODO: should we foresee a flag FORCE_USE_BOOST ?

//Set build option for the Bessel functions.
// 1) from STL (if C++ version > 14)
// 2) from Boost library

#include <limits>

#if PXRMP_INTERNAL_SPECFUNC_WITH_CXX17
    #include <cmath>
#elif defined(PXRMP_INTERNAL_SPECFUNC_WITH_BOOST)
    #include <boost/math/special_functions/bessel.hpp>
#endif

//Should be included by all the src files of the library
#include "../qed_commons.h"

//############################################### Declaration

namespace picsar{
namespace multi_physics{
namespace math{

        //For the moment we need just modified Bessel functions of the
        //second kind.
        //Different combinations of argument types can be accepted
        //(e.g. double + double or double + float).
    #ifdef PXRMP_INTERNAL_SPECFUNC_WITH_CXX17
        using k_v = std::cyl_bessel_k(v, x);
    #elif defined(PXRMP_INTERNAL_SPECFUNC_WITH_BOOST)
        using k_v = boost::math::cyl_bessel_k(v, x);
    #endif

}
}
}

#endif //__PICSAR_MULTIPHYSICS_SPECIAL_FUNCTIONS__