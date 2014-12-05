class BoundingArea
  def initialize(boxes)
    @boxes = boxes
  end

  def contains_point?(x, y)
    @boxes.each { |box| return true if box.contains_point?(x, y) }
    false
  end
end
