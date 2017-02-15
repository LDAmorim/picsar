! ________________________________________________________________________________________
!
! *** Copyright Notice ***
!
! “Particle In Cell Scalable Application Resource (PICSAR) v2”, Copyright (c)
! 2016, The Regents of the University of California, through Lawrence Berkeley
! National Laboratory (subject to receipt of any required approvals from the
! U.S. Dept. of Energy). All rights reserved.
!
! If you have questions about your rights to use or distribute this software,
! please contact Berkeley Lab's Innovation & Partnerships Office at IPO@lbl.gov.
!
! NOTICE.
! This Software was developed under funding from the U.S. Department of Energy
! and the U.S. Government consequently retains certain rights. As such, the U.S.
! Government has been granted for itself and others acting on its behalf a
! paid-up, nonexclusive, irrevocable, worldwide license in the Software to
! reproduce, distribute copies to the public, prepare derivative works, and
! perform publicly and display publicly, and to permit other to do so.
!
! SIMPLE_IO.F90
!
! This file contains subroutines for Picsar outputs.
!
! Developers:
! Henri Vincenti
! Mathieu Lobet
!
! Date:
! Creation 2015
! ________________________________________________________________________________________

! ________________________________________________________________________________________
!> @brief
!> This module contains subroutines for the outputs.
!
!> @author
!> Henri Vincenti
!
!> @date
!> Creation 2015
! ________________________________________________________________________________________
MODULE simple_io

  USE mpi_derived_types
  USE fields
  USE shared_data
  IMPLICIT NONE

CONTAINS

    ! ____________________________________________________________________________________
    !> @brief
    !> This subroutine manages all diagnostic outputs.
    !
    !> @author
    !> Henri Vincenti
    !
    !> @date
    !> Creation 2015
    ! ____________________________________________________________________________________
    SUBROUTINE output_routines()
        USE shared_data
        USE params
        USE time_stat
        USE diagnostics
        IMPLICIT NONE

        CHARACTER(LEN=string_length) :: strtemp
        REAL(num) :: tmptime,tmptime2

#if defined(DEBUG)
        WRITE(0,*) "Output_routines: start"
#endif

        IF (it.ge.timestat_itstart) THEN
        tmptime = MPI_WTIME()
        ENDIF

        WRITE(strtemp,'(I5)') it

        IF (output_frequency .GE. 1) THEN
        tmptime2 = MPI_WTIME()
        IF ((it .GE. output_step_min) .AND. (it .LE. output_step_max) .AND. &
            (MOD(it-output_step_min,output_frequency) .EQ. 0)) THEN
            !!! --- Write output to disk
            !! -- Write grid quantities
            IF (c_output_ex .EQ. 1) THEN
                ! - Write current density ex

                !CALL write_single_array_to_file('./RESULTS/'//TRIM(ADJUSTL(fileex))// &
                !TRIM(ADJUSTL(strtemp))//'.pxr', ex, nxguards, nyguards, nzguards, nx,ny,nz, offset, err)

                IF (rank.eq.0) WRITE(0,*) "Write electric field ex"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(fileex))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', ex,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)

            ENDIF
            IF (c_output_ey .EQ. 1) THEN
                ! - Write current density ey
                IF (rank.eq.0) WRITE(0,*) "Write electric field ey"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(fileey))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', ey,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_ez .EQ. 1) THEN
                ! - Write current density ez
                IF (rank.eq.0) WRITE(0,*) "Write electric field ez"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(fileez))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', ez,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_bx .EQ. 1) THEN
                ! - Write magnetic field bx
                IF (rank.eq.0) WRITE(0,*) "Write magnetic field bx"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filebx))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', bx,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_by .EQ. 1) THEN
                ! - Write current density by
                IF (rank.eq.0) WRITE(0,*) "Write magnetic field by"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(fileby))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', by,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_bz .EQ. 1) THEN
                ! - Write current density bz
                IF (rank.eq.0) WRITE(0,*) "Write magnetic field bz"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filebz))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', bz,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_jx .EQ. 1) THEN
                ! - Write current density jx
                IF (rank.eq.0) WRITE(0,*) "Write current density jx"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filejx))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', jx,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_jy .EQ. 1) THEN
                ! - Write current density jy
                IF (rank.eq.0) WRITE(0,*) "Write current density jy"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filejy))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', jy,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_jz .EQ. 1) THEN
                ! - Write current density jz
                IF (rank.eq.0) WRITE(0,*) "Write current density jz"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filejz))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', jz,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_dive .EQ. 1) THEN

                ! Computation if not already done
                IF (.not.(divE_computed))  then
                  CALL calc_field_div(dive, ex, ey, ez, nx, ny, nz, nxguards, nyguards, nzguards, dx, dy, dz)
                  divE_computed = .true.
                ENDIF

                ! - Write electric field divergence div E
                IF (rank.eq.0) WRITE(0,*) "Write electric field divergence div E"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filedive))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', dive,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF
            IF (c_output_rho .EQ. 1) THEN
                ! - Write total charge density rho
                IF (rank.eq.0) WRITE(0,*) "Write total charge density rho"
                CALL write_3d_field_array_to_file('./RESULTS/'//TRIM(ADJUSTL(filerho))// &
                TRIM(ADJUSTL(strtemp))//'.pxr', rho,     &
                xmin, xmax, ymin, ymax, zmin, zmax, nxguards, nyguards, nzguards, nx, &
                ny, nz, nx_global, ny_global, nz_global)
            ENDIF

            ENDIF
          tmptime2 = MPI_WTIME() - tmptime2
          IF (rank .EQ. 0) PRINT *, "Fields dump in ", tmptime2, " (s)"
        ENDIF

        IF (it.ge.timestat_itstart) THEN
        localtimes(9) = localtimes(9) + (MPI_WTIME() - tmptime)
        ENDIF

        !!! --- Write particle diags
        CALL write_particles_to_file

        !!! --- Output temporal diagnostics
        CALL output_temporal_diagnostics

        !!! --- Output time statistics
        CALL output_time_statistics

#if defined(DEBUG)
        WRITE(0,*) "Output_routines: stop"
#endif

    END SUBROUTINE output_routines

    ! ____________________________________________________________________________________
    !> @brief
    !> This subroutine outputs temporal diagnostics
    !> (evolution of integrated quantities as a function of the time)
    !
    !> @author
    !> Henri Vincenti
    !
    !> @date
    !> Creation 2015
    ! ____________________________________________________________________________________
    SUBROUTINE output_temporal_diagnostics
        USE shared_data
        USE params
        USE time_stat
        USE diagnostics
        USE output_data
        USE particle_properties
        USE constants
        USE fields
        IMPLICIT NONE

        REAL(num), dimension(:), allocatable :: local_values,global_values
        INTEGER(idp) :: ispecies
        INTEGER(isp) :: i
        REAL(num) :: tmptime

#if defined(DEBUG)
        WRITE(0,*) "output_temporal_diagnostics: start"
#endif

        IF ((temdiag_frequency.gt.0).and.(MOD(it,temdiag_frequency).EQ. 0)) THEN

          tmptime = MPI_WTIME()

          Allocate(local_values(temdiag_totvalues),global_values(temdiag_totvalues))

          ! Kinetic energy
          if (temdiag_act_list(1).gt.0) then
            DO ispecies=1,nspecies
              CALL get_loc_kinetic_energy(ispecies,local_values(temdiag_i_list(1)+ispecies-1))
              local_values(temdiag_i_list(1)+ispecies-1) = local_values(temdiag_i_list(1)+ispecies-1)*emass*clight**2
              !if (local_values(temdiag_i_list(1)+ispecies-1) .lt. 1E-15) local_values(temdiag_i_list(1)+ispecies-1)=1e-15
            ENDDO
          end if

          ! Ex energy
          if (temdiag_act_list(2).gt.0) then
            CALL get_loc_field_energy(ex,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(2)))
            local_values(temdiag_i_list(2)) = local_values(temdiag_i_list(2))*eps0
          end if

          ! Ey energy
          if (temdiag_act_list(3).gt.0) then
            CALL get_loc_field_energy(ey,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(3)))
            local_values(temdiag_i_list(3)) = local_values(temdiag_i_list(3))*eps0
          end if


          ! Ez energy
          if (temdiag_act_list(4).gt.0) then
            CALL get_loc_field_energy(ez,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(4)))
            local_values(temdiag_i_list(4)) = local_values(temdiag_i_list(4))*eps0
          end if

          ! Bx energy
          if (temdiag_act_list(5).gt.0) then
            CALL get_loc_field_energy(bx,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(5)))
            local_values(temdiag_i_list(5)) = local_values(temdiag_i_list(5))*imu0
          end if

          ! By energy
          if (temdiag_act_list(6).gt.0) then
            CALL get_loc_field_energy(by,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(6)))
            local_values(temdiag_i_list(6)) = local_values(temdiag_i_list(6))*imu0
          end if

          ! Bz energy
          if (temdiag_act_list(7).gt.0) then
            CALL get_loc_field_energy(bz,nx,ny,nz,dx,dy,dz,nxguards,nyguards,nzguards,local_values(temdiag_i_list(7)))
            local_values(temdiag_i_list(7)) = local_values(temdiag_i_list(7))*imu0
          end if

          ! ||DivE*eps0 - rho||
          if (temdiag_act_list(8).gt.0) then
            ! Computation oif divE if not already done
            IF (.not.(divE_computed))  then
              CALL calc_field_div(dive, ex, ey, ez, nx, ny, nz, nxguards, nyguards, nzguards, dx, dy, dz)
              divE_computed = .true.
            ENDIF
            CALL get_loc_norm_divErho(dive,rho,nx, ny, nz, nxguards, nyguards, nzguards,local_values(temdiag_i_list(8)))
            local_values(temdiag_i_list(8)) = local_values(temdiag_i_list(8))
          end if

          ! ||rho||
          if (temdiag_act_list(9).gt.0) then
            CALL get_loc_norm_2(rho,nx, ny, nz, nxguards, nyguards, nzguards,local_values(temdiag_i_list(9)))
            local_values(temdiag_i_list(9)) = local_values(temdiag_i_list(9))
          end if

          ! ||divE||
          if (temdiag_act_list(10).gt.0) then
            ! Computation oif divE if not already done
            IF (.not.(divE_computed))  then
              CALL calc_field_div(dive, ex, ey, ez, nx, ny, nz, nxguards, nyguards, nzguards, dx, dy, dz)
              divE_computed = .true.
            ENDIF
            CALL get_loc_norm_2(dive,nx, ny, nz, nxguards, nyguards, nzguards,local_values(temdiag_i_list(10)))
            local_values(temdiag_i_list(10)) = local_values(temdiag_i_list(10))
          end if

          ! MPI all reduction
          call MPI_ALLREDUCE(local_values(1),global_values(1),INT(temdiag_totvalues,isp),mpidbl,MPI_SUM,comm,errcode)

          ! sqrt for DivE*eps0 - rho
          if (temdiag_act_list(8).gt.0) then
            global_values(temdiag_i_list(8)) = sqrt(global_values(temdiag_i_list(8)))
          end if
          ! sqrt for ||rho||**2
          if (temdiag_act_list(9).gt.0) then
            global_values(temdiag_i_list(9)) = sqrt(global_values(temdiag_i_list(9)))
          end if
          ! sqrt for ||divE||**2
          if (temdiag_act_list(10).gt.0) then
            global_values(temdiag_i_list(10)) = sqrt(global_values(temdiag_i_list(10)))
          end if

          ! _____________
          ! Debug
          !IF (rank==0) THEN
          !  write(0,*) temdiag_totvalues
          !  write(0,*) local_values(temdiag_i_list(1):temdiag_i_list(1)+temdiag_nb_values(1)-1)
          !  write(0,*) global_values(temdiag_i_list(1):temdiag_i_list(1)+temdiag_nb_values(1)-1)
          !  write(0,*) 'exE',global_values(temdiag_i_list(2):temdiag_i_list(2)+temdiag_nb_values(2)-1)
          !  write(0,*) 'eyE',global_values(temdiag_i_list(3):temdiag_i_list(3)+temdiag_nb_values(3)-1)
          !  write(0,*) 'ezE',global_values(temdiag_i_list(4):temdiag_i_list(4)+temdiag_nb_values(4)-1)
          !ENDIF

          ! Output
          ! Each mpi task will write in a given file according to their rank
          IF (nproc.ge.temdiag_nb) then
            IF ((rank.ge.0).and.(rank.le.temdiag_nb)) then

              ! Ascii format
              IF (temdiag_format.eq.1) then
                !write(42,'(X,3(E14.10E3,X))') local_values(temdiag_i_list(rank+1):temdiag_i_list(rank+1)+temdiag_nb_values(rank+1)-1)
                write(42,*) global_values(temdiag_i_list(rank+1):temdiag_i_list(rank+1)+temdiag_nb_values(rank+1)-1)

              ! Binary format
              ELSE
                write(42) global_values(temdiag_i_list(rank+1):temdiag_i_list(rank+1)+temdiag_nb_values(rank+1)-1)
              ENDIF

            end if
          else
            if (rank.eq.0) then
              DO i=1,temdiag_nb
                IF (temdiag_format.eq.1) then
                  !write(42,'(X,3(E14.10,X))') local_values(temdiag_i_list(i):temdiag_i_list(i)+temdiag_nb_values(i)-1)
                  write(42+i,*) global_values(temdiag_i_list(i):temdiag_i_list(i)+temdiag_nb_values(i)-1)
                ! Binary format
                else
                  write(42+i) global_values(temdiag_i_list(i):temdiag_i_list(i)+temdiag_nb_values(i)-1)
                end if
              ENDDO
            ENDIF
          ENDIF

          !CALL get_kinetic_energy(ispecies,temp_diag(1))
          !if (rank==0) write(0,*) "kinetic energy",temp_diag(1)

          localtimes(9) = localtimes(9) + (MPI_WTIME() - tmptime)

        ENDIF

#if defined(DEBUG)
        WRITE(0,*) "output_temporal_diagnostics: stop"
#endif

    END SUBROUTINE


  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine writes the field arrays (e.g EM fields, Currents)
  !> to disk using MPI-IO.
  !> The files have a header with the main parameters
  !
  !> Modification:
  !> Mathieu Lobet - 2016 - Header with the main parameters
  !
  !> @author
  !> Henri Vincenti
  !> Mathieu Lobet
  !
  !> @date
  !> Creation 2015
  !
  !> @param[in] filename name of the file
  !> @param[in] array the array to be output
  !> @param[in] xmin2 minimum x limit
  !> @param[in] xmax2 maximum x limit
  !> @param[in] ymin2 minimum y limit
  !> @param[in] ymax2 maximum y limit
  !> @param[in] zmin2 minimum z limit
  !> @param[in] zmax2 maximum z limit
  !> @param[in] nxg guard cells in x
  !> @param[in] nyg guard cells in y
  !> @param[in] nzg guard cells in z
  !> @param[in] nx_local local size in x
  !> @param[in] ny_local local size in y
  !> @param[in] nz_local local size in z
  !> @param[in] nx_global2 global size in x
  !> @param[in] ny_global2 global size in y
  !> @param[in] nz_global2 global size in z
  !
  SUBROUTINE write_3d_field_array_to_file(filename, array,     &
             xmin2, xmax2, ymin2, ymax2, zmin2, zmax2, nxg, nyg, nzg, nx_local, &
             ny_local, nz_local, nx_global2, ny_global2, nz_global2)
  ! ______________________________________________________________________________________

    IMPLICIT NONE

    CHARACTER(LEN=*), INTENT(IN)              :: filename
    INTEGER(idp), INTENT(IN)                  :: nxg, nyg, nzg
    INTEGER(idp), INTENT(IN)                  :: nx_local, ny_local, nz_local
    INTEGER(idp), INTENT(IN)                  :: nx_global2, ny_global2, nz_global2
    REAL(num), INTENT(IN)                     :: xmin2,xmax2,ymin2,ymax2,zmin2,zmax2
    REAL(num), DIMENSION(-nxg:nx_local+nxg,-nyg:ny_local+nyg,-nzg:nz_local+nzg), INTENT(IN OUT) :: array
    INTEGER(KIND=MPI_OFFSET_KIND)             :: offset
    INTEGER(isp)                              :: err

    ! Creation of the header by the processor 0
    IF (rank.eq.0) THEN
      open(unit=42,file=filename,FORM="unformatted",ACCESS='stream')
      write(42) xmin, xmax, INT(nx_global,isp)
      write(42) ymin, ymax, INT(ny_global,isp)
      write(42) zmin, zmax, INT(nz_global,isp)
      close(42)
    ENDIF

    ! Size of the header in bytes
    offset = 8*6 + 4*3

    CALL MPI_BARRIER(comm,errcode)

    ! Core of the file
    CALL write_single_array_to_file(filename, array, nxg, nyg, nzg, nx_local, &
                                    ny_local, nz_local, offset, err)

  END SUBROUTINE write_3d_field_array_to_file

  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine writes a grid quantity (e.g EM fields, Currents)
  !> to disk using MPI-IO
  !
  !> @author
  !> Henri Vincenti
  !> Mathieu Lobet
  !
  !> @date
  !> Creation 2015
  !
  !> @param[in] filename name of the file
  !> @param[in] array the array to be output
  !> @param[in] nxg guard cells in x
  !> @param[in] nyg guard cells in y
  !> @param[in] nzg guard cells in z
  !> @param[in] nx_local local size in x
  !> @param[in] ny_local local size in y
  !> @param[in] nz_local local size in z
  !> @param[in] offset offset for the header
  !> @param[inout] err error parameter
  !
  SUBROUTINE write_single_array_to_file(filename, array, nxg, nyg, nzg, &
                                        nx_local, ny_local, nz_local, offset, err)
  ! ______________________________________________________________________________________

    CHARACTER(LEN=*), INTENT(IN)              :: filename
    INTEGER(idp), INTENT(IN)                  :: nxg, nyg, nzg
    INTEGER(idp), INTENT(IN)                  :: nx_local, ny_local, nz_local
    REAL(num), DIMENSION(-nxg:nx_local+nxg,-nyg:ny_local+nyg,-nzg:nz_local+nzg), INTENT(IN OUT) :: array
    INTEGER(KIND=MPI_OFFSET_KIND), INTENT(IN) :: offset
    INTEGER(isp), INTENT(INOUT)               :: err
    INTEGER(isp)                              :: subt, suba, fh

    CALL MPI_FILE_OPEN(comm, TRIM(filename), MPI_MODE_CREATE + MPI_MODE_WRONLY, &
        MPI_INFO_NULL, fh, errcode)


    IF (errcode .NE. 0) THEN
      IF (rank .EQ. 0) PRINT *, 'file ', TRIM(filename), 'could not be created - Check disk space'
      err = IOR(err, c_err_bad_value)
      RETURN
    ENDIF

    subt = create_current_grid_derived_type()
    suba = create_current_grid_subarray(nxg, nyg, nzg)


    CALL MPI_FILE_SET_VIEW(fh, offset, MPI_BYTE, subt, 'native', &
        MPI_INFO_NULL, errcode)


    CALL MPI_FILE_WRITE_ALL(fh, array, 1_isp, suba, MPI_STATUS_IGNORE, errcode)


     CALL MPI_FILE_CLOSE(fh, errcode)
     CALL MPI_TYPE_FREE(subt, errcode)

  END SUBROUTINE write_single_array_to_file


  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine dumps the particle properties in a file.
  !>
  !> @author
  !> Henri Vincenti
  !
  !> @date
  !> Creation 2015
  SUBROUTINE write_particles_to_file
  ! ______________________________________________________________________________________
    USE particles
    USE constants
    USE params
    USE time_stat

    REAL(num), ALLOCATABLE, DIMENSION(:)    :: arr
    LOGICAL(lp) , ALLOCATABLE, DIMENSION(:) :: mask
    INTEGER(idp)                            :: narr, idump, ncurr, ndump
    INTEGER(isp)                            :: fh
    INTEGER(idp)                            :: offset
    TYPE(particle_species), POINTER         :: curr
    TYPE(particle_dump), POINTER            :: dp
    REAL(num)                               :: tmptime, tottime, t0
    CHARACTER(LEN=5)                        :: strit

    t0 = MPI_WTIME()

    WRITE(strit,'(I5)') it

    tottime = 0_num
    DO idump = 1, npdumps

      ! POINT TOWARDS CURRENT SPECIES
      dp => particle_dumps(idump)

      IF (dp%diag_period .lt.1) CYCLE
      IF (MOD(it,dp%diag_period) .NE. 0) CYCLE

      tmptime = MPI_WTIME()

      curr => species_parray(dp%ispecies)
      narr = curr%species_npart

      ! GET TOTAL NUMBER OF PART TO DUMP
      ALLOCATE(mask(narr))
      CALL get_particles_to_dump(idump,mask,narr,ndump)

      CALL MPI_ALLREDUCE(ndump,ncurr,1_isp, MPI_INTEGER8, MPI_SUM, comm, errcode)

      ! OPENING INPUT FILE
      CALL MPI_FILE_OPEN(comm, TRIM('./RESULTS/'//TRIM(ADJUSTL(curr%name))//'_it_'// &
      TRIM(ADJUSTL(strit))),MPI_MODE_CREATE + MPI_MODE_WRONLY, MPI_INFO_NULL, fh, errcode)

      ALLOCATE(arr(ndump))

      ! WRITE - X
      offset = 0
      CALL concatenate_particle_variable(idump, 1_idp, arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr,ndump, mpidbl, errcode, offset)
      ! WRITE - Y

      offset = offset + ndump* SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 2_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)
      ! WRITE - Z
      offset = offset + ndump * SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 3_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)

      ! WRITE - Ux
      offset = offset + ndump * SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 4_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)

      ! WRITE - Uy
      offset = offset + ndump * SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 5_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)

      ! WRITE - Uz
      offset = offset + ndump * SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 6_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)

      ! WRITE - Weight
      offset = offset + ndump * SIZEOF(arr(1))
      CALL concatenate_particle_variable(idump, 7_idp,  arr, ndump, mask, narr)
      CALL write_particle_variable(fh, arr, ndump, mpidbl, errcode, offset)

      DEALLOCATE(arr, mask)

      CALL MPI_FILE_CLOSE(fh, errcode)
      tottime = MPI_WTIME()-tmptime
      IF (rank .EQ. 0) WRITE(0,'(" Total part dump time ", F12.5 , &
" (s) for species ",A10)') tottime, species_parray(dp%ispecies)%name
    END DO ! END LOOP ON SPECIES

    ! Global time statistics
    IF (it.ge.timestat_itstart) THEN
      localtimes(9) = localtimes(9) + ( MPI_WTIME() - t0 )
    ENDIF

  END SUBROUTINE write_particles_to_file

  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine dumps the particle properties in a file.
  !>
  !> @author
  !> Henri Vincenti
  !
  !> @date
  !> Creation 2015
  SUBROUTINE get_particles_to_dump(idump,mask,narr,ndump)
  ! ______________________________________________________________________________________

    USE constants
    USE particles
    USE tiling
    USE output_data

    INTEGER(idp), INTENT(IN) :: idump, narr
    INTEGER(idp), INTENT(IN OUT) :: ndump
    LOGICAL(lp) , DIMENSION(narr), INTENT(IN OUT) :: mask
    INTEGER(idp) :: ix, iy, iz, count, ip
    TYPE(particle_species), POINTER :: curr
    TYPE(particle_dump), POINTER :: dp
    TYPE(particle_tile), POINTER :: curr_tile
    REAL(num) :: partx, party, partz, partux, partuy, partuz
    ndump = 0
    mask = .FALSE.

    dp => particle_dumps(idump)
    curr => species_parray(dp%ispecies)
    DO iz=1,ntilez
        DO iy=1,ntiley
            DO ix=1,ntilex
                curr_tile=>curr%array_of_tiles(ix,iy,iz)
                count=curr_tile%np_tile(1)
                IF (count .EQ. 0) THEN
                  CYCLE
                ELSE
                  DO ip = 1, count
                      partx= curr_tile%part_x(ip)
                      party= curr_tile%part_y(ip)
                      partz= curr_tile%part_z(ip)
                      partux= curr_tile%part_ux(ip)
                      partuy= curr_tile%part_uy(ip)
                      partuz= curr_tile%part_uz(ip)
                      IF ((partx .GT. dp%dump_x_min) .AND. (partx .LT. dp%dump_x_max) .AND. &
                          (party .GT. dp%dump_y_min) .AND. (party .LT. dp%dump_y_max) .AND. &
                          (partz .GT. dp%dump_z_min) .AND. (partz .LT. dp%dump_z_max) .AND. &
                          (partux .GT. dp%dump_ux_min) .AND. (partux .LT. dp%dump_ux_max) .AND. &
                          (partuy .GT. dp%dump_uy_min) .AND. (partuy .LT. dp%dump_uy_max) .AND. &
                          (partuz .GT. dp%dump_uz_min) .AND. (partuz .LT. dp%dump_uz_max)) THEN
                          ndump = ndump+1
                          mask(ip) = .TRUE.
                      ENDIF
                  END DO
                ENDIF
            END DO
        END DO
    END DO!END LOOP ON TILES

  END SUBROUTINE get_particles_to_dump

  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine creates a new array of particles (narr)
  !> from the current particle array (arr) and a list of flags (mask) for filtering.
  !>
  !> @author
  !> Henri Vincenti
  !
  !> @date
  !> Creation 2015
  SUBROUTINE concatenate_particle_variable(idump, var, arr, narr, mask, nmask)
  ! ______________________________________________________________________________________

  USE particles
  USE constants
  USE tiling
  INTEGER(idp), INTENT(IN) :: idump, narr, var, nmask
  LOGICAL(lp) , DIMENSION(nmask), INTENT(IN) :: mask
  REAL(num), DIMENSION(narr), INTENT(IN OUT) :: arr
  INTEGER(idp) :: ix, iy, iz, count, ncurr, np, ip
  TYPE(particle_species), POINTER :: curr
  TYPE(particle_tile), POINTER :: curr_tile
  TYPE(particle_dump), POINTER :: dp
  ncurr = 0
  np = 0

  dp => particle_dumps(idump)
  curr => species_parray(dp%ispecies)
  DO iz=1,ntilez
      DO iy=1,ntiley
          DO ix=1,ntilex
              curr_tile=>curr%array_of_tiles(ix,iy,iz)
              count=curr_tile%np_tile(1)
              IF (count .EQ. 0) THEN
                CYCLE
              ELSE
                SELECT CASE (var)
                CASE (1) ! x
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_x(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (2) ! y
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_y(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (3) ! z
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_z(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (4) ! ux
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_ux(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (5) ! uy
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_uy(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (6) ! uz
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%part_uz(ip)
                            ncurr = ncurr+1
                        END IF
                    END DO
                CASE (7) ! weight
                    DO ip=1,count
                        np = np+1
                        IF (mask(np)) THEN
                            arr(ncurr+1) = curr_tile%pid(ip,wpid)
                            ncurr = ncurr+1
                        END IF
                    END DO
                END SELECT
              ENDIF
          END DO
      END DO
  END DO!END LOOP ON TILES

  END SUBROUTINE concatenate_particle_variable

  ! ______________________________________________________________________________________
  !> @brief
  !> This subroutine writes a particle array property (e.g x, y,z, px etc.)
  !> in the file  of file handler fh. The array is appended at offset (in bytes) in fh.
  !
  !> @author
  !> Henri Vincenti
  !
  !> @date
  !> Creation 2015
  SUBROUTINE write_particle_variable(fh, array, narr, mpitype, err, offset)
  ! ______________________________________________________________________________________
    INTEGER(isp), INTENT(IN) :: fh
    INTEGER(idp), INTENT(IN) :: narr
    REAL(num), DIMENSION(narr), INTENT(IN) :: array
    INTEGER(idp), INTENT(IN) :: offset
    INTEGER(isp), INTENT(IN) :: mpitype
    INTEGER(isp), INTENT(INOUT) :: err

    !CALL MPI_FILE_OPEN(comm, TRIM(filename), MPI_MODE_CREATE + MPI_MODE_WRONLY, &
    !MPI_INFO_NULL, fh, err)

    CALL MPI_FILE_SET_VIEW(fh, offset, MPI_BYTE, mpitype, 'native', &
    MPI_INFO_NULL, err)

    CALL MPI_FILE_WRITE_ALL(fh, array, INT(narr,isp), mpitype, MPI_STATUS_IGNORE, err)

  END SUBROUTINE write_particle_variable

  ! ______________________________________________________________________________________
  !> @brief
  !> Output of the time statistics
  !
  !> @author
  !> Mathieu Lobet
  !
  !> @date
  !> Creation 2016
  SUBROUTINE output_time_statistics
  ! ______________________________________________________________________________________

    USE time_stat
    USE params
    USE shared_data
    IMPLICIT NONE

    REAL(num), DIMENSION(20) :: avetimes

#if defined(DEBUG)
        WRITE(0,*) "output_time_statistic: start"
#endif

    IF ((timestat_period.gt.0).and.(MOD(it,timestat_period).eq.0)) then


      localtimes(20) = sum(localtimes(1:13))
      localtimes(19) = localtimes(2) + localtimes(4) + localtimes(6) + &
                       localtimes(8) + localtimes(11) + localtimes(13)

      ! Average
      CALL MPI_REDUCE(localtimes,avetimes,20_isp,mpidbl,MPI_SUM,0_isp,comm,errcode)
      avetimes = avetimes / nproc

      buffer_timestat(1:13,itimestat) = avetimes(1:13)
      itimestat = itimestat + 1

      ! Flush entire buffer when full
      IF (itimestat.gt.nbuffertimestat) THEN

        IF (rank.eq.0) THEN
          write(41) buffer_timestat(1:13,1:nbuffertimestat)
        end if

        itimestat=1

      END IF

    endif

#if defined(DEBUG)
        WRITE(0,*) "output_time_statistic: stop"
#endif

  END SUBROUTINE


  ! ______________________________________________________________________________________
  !> @brief
  !> Output of the time statistics at the end of the simulation.
  !> Purge the buffer.
  !
  !> @author
  !> Mathieu Lobet
  !
  !> @date
  !> Creation 2016
  SUBROUTINE final_output_time_statistics
  ! ______________________________________________________________________________________

    USE time_stat
    USE params
    USE shared_data
    IMPLICIT NONE

    IF (timestat_activated.gt.0) THEN

      write(41) buffer_timestat(1:13,1:itimestat)

    END IF

  END SUBROUTINE

END MODULE simple_io