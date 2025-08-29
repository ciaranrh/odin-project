def bubble_sort(input)
  for i in 0...input.length
    for j in 0...input.length - 1
      if input[j] > input[j+1]
        temp = input[j]
        input[j] = input[j+1]
        input[j+1] = temp
      end
    end
  end

  p input
end

bubble_sort([4,3,78,2,0,2]) # should return [0,2,2,3,4,78]