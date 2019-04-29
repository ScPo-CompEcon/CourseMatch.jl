#returns squareroot of sum of squares, i.e. positive number
function  z(x::Matrix{Int64}, q::Vector{Int64}, p::Vector{Int64})
   # S is the number of students, N is the number of courses
   # x is the SxN allocation matrix
   # q is the Nx1 course capacity vector
   # p is the Nx1 price vector
   N = length(q)
   zer = zeros(N)        #Create empty Nx1 vector of clearing errors
   numstud = transpose(sum(x, dims = 1)) #Create Nx1 vector with the number of students enrolled in each course.
   for i in 1:N        #For every course
       if p[i] > 0     #As long as the price in this course is positive.
           zer[i] = numstud[i] - q[i]
       else
           zer[i] = max(numstud[i] - q[i], 0)
       end
   end
   α = sqrt(sum(zer.^2))
   return α
end

export z
