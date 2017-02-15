%R is the distance traveled, N is the number of steps taken
function pn = randomwalk(R,N)

  pn = 2*(R/N) * exp(-R^2/N)

end
