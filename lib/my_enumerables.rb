module Enumerable
  def my_each_with_index
    index = 0

    my_each do |element|
      yield element, index
      index += 1
    end
  end

  def my_select
    selected_items = []

    my_each do |element|
      selected_items << element if yield(element)
    end

    selected_items
  end

  def my_all?
    passed_elements = []

    my_each do |element|
      if block_given?
        passed_elements << element if yield(element)
      elsif element
        passed_elements << element
      end
    end

    passed_elements == self
  end

  def my_any?
    passed_elements = []

    my_each do |element|
      if block_given?
        passed_elements << element if yield(element)
      elsif element
        passed_elements << element
      end
    end

    !passed_elements.empty?
  end

  def my_none?
    passed_elements = []

    my_each do |element|
      if block_given?
        passed_elements << element if yield(element)
      elsif element
        passed_elements << element
      end
    end

    passed_elements.empty?
  end

  def my_count
    element_counter = 0

    my_each do |element|
      if block_given?
        element_counter += 1 if yield(element)
      else
        element_counter = length
        break
      end
    end

    element_counter
  end

  def my_map
    updated_array = []

    my_each do |element|
      updated_array << yield(element) if block_given?
    end

    updated_array
  end

  def my_inject(initial_value)
    final_value = initial_value

    my_each do |element|
      final_value = element if final_value.nil?

      final_value = yield(final_value, element)
    end

    final_value
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_each
    for element in self
      yield element
    end
    self
  end
end
