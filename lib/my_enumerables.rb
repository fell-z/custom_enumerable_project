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

  def my_all?(obj = :not_given)
    approved_elements_count = 0

    my_each do |element|
      if obj == :not_given && !block_given?
        approved_elements_count += 1 if element
      else
        obj = nil

        approved_elements_count += 1 if element == obj || yield(element)
      end
    end

    approved_elements_count == length
  end

  def my_any?(obj = nil)
    passed = false

    my_each do |element|
      if block_given? || obj
        break passed = true if element == obj || yield(element)
      elsif element
        break passed = true
      end
    end

    passed
  end

  def my_none?(obj = nil)
    passed = true

    my_each do |element|
      if block_given? || obj
        break passed = false if element == obj || yield(element)
      elsif element
        break passed = false
      end
    end

    passed
  end

  def my_count(obj = nil)
    return length unless block_given? || obj

    element_counter = 0

    my_each do |element|
      element_counter += 1 if element == obj || yield(element)
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
