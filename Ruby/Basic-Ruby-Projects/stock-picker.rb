def stock_picker(input)
  cur_dif = 0
  min_day = 0
  max_day = 0

  input.each_with_index do |day, index|
    input[(index+1)..].each_with_index do |sub_day, sub_index| 
      actual_sub = sub_index + index + 1 #slice an array with input[(index+1)..], creates NEW array, and each_with_index starts counting from 0 for that new array, keeping this for educational purposes ;)
      dif = input[actual_sub] - input[index]
      if dif > cur_dif
        min_day = index
        max_day = actual_sub
        cur_dif = dif
      end
    end
  end

  results = [min_day, max_day]
  p results
end

stock_picker([17,3,6,9,15,8,6,1,10]) # should return [1,4]  # for a profit of $15 - $3 == $12
