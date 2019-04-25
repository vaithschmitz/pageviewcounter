require 'CSV'

class Parser 
    attr_reader :row, :log

    def initialize(log)
        @route = Array.new
        @unique = Hash.new { |h, k| h[k] = [] }
        @log 
    end

    def most_viewed
        CSV.foreach(log) do |row|  
            x = row.to_s.split
            x[0][0..2] = ''
            @route.push(x[0])
        end
        x  = @route.uniq.map{|x| [x, @route.count(x)]}.to_h
        x.sort_by{|k,v| v}.reverse
    end

    def most_unique 
        CSV.foreach(log) do |row|  
            x = row.to_s.split   
            x[0][0..2] = ''
            @unique[x[0]] << x[1]
        end   
        x = @unique.map{|x, y| [x,  y.uniq.count]}.to_h
        x.sort_by{|k,v| v}.reverse
    end

end

parser = Parser.new
puts "Most viewed pages: "
puts parser.most_viewed
puts ""
puts "Most unique page views:"
puts parser.most_unique