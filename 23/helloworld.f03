program helloworld
  implicit none

  real:: a, b, result

  integer(kind = 1):: tinyval
  integer(kind = 2):: shortval
  integer(kind = 4):: intval
  integer(kind = 8):: longval
  integer(kind = 16):: verylongval

  a = 12.0
  b = 15.0
  result = a+b
  print *, 'The total is ', result
  print *, "Oh, hello world btw"

  print *, "The highest value for 1 byte is", huge(tinyval)
  print *, "The highest value for 2 byte is", huge(shortval)
  print *, "The highest value for 4 byte is", huge(intval)
  print *, "The highest value for 8 byte is", huge(longval)
  print *, "The highest value for 16 byte is", huge(verylongval)

end program helloworld
