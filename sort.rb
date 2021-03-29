class Sort
  def initialize
    @self = []
  end

  def add(str)
    @self.push(str) unless @self.include? str
    @self.sort!
  end

  def print
    @self.each do |element|
      puts element
    end
  end
end

title_list = Sort.new

title_list.add 'a'
title_list.add 'n'
title_list.add '33'
title_list.print
