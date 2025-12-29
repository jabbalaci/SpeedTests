program speedtest

  integer, parameter :: MAX_N = 440000000
  integer, dimension(10) :: cache
  call calc_cache(cache)
  do i = 0, MAX_N
    if (is_munchausen(cache, i)) then
      print '(i0)', i
    end if
  end do

contains

subroutine calc_cache(cache)
  integer, dimension(10), intent(out) :: cache

  cache(1) = 0
  do i = 1, 9
    cache(i+1) = i**i
  end do
end subroutine

logical function is_munchausen(cache, num)
  integer, dimension(10), intent(in) :: cache
  integer, intent(in) :: num

  integer :: n, total, digit
  n = num
  total = 0
  do while (n > 0)
    digit = mod(n, 10)
    total = total + cache(digit+1)
    if (total > num) then
      is_munchausen = .false.
      return
    end if
    n = n / 10
  end do

  is_munchausen = total == num
end function

end program speedtest
